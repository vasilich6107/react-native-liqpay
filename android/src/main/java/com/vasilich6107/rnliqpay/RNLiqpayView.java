package com.vasilich6107.rnliqpay;

import android.content.Context;
import android.graphics.Canvas;
import android.view.View;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.events.RCTEventEmitter;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import ua.privatbank.paylibliqpay.ErrorCode;
import com.vasilich6107.rnliqpay.LiqPay;
import ua.privatbank.paylibliqpay.LiqPayCallBack;

class RNLiqpayView extends View implements LiqPayCallBack {
  private Context context = null;
  private String privateKey = null;
  private String type = null;
  private String signature = null;
  private String paramsBase64 = null;
  private Boolean isPresented = false;
  private String path;
  private Map<ErrorCode, String> errorCodeNames;
  private HashMap<String, String> params;

  public RNLiqpayView(Context context) {
    super(context);
    this.context = context;

    this.errorCodeNames = new HashMap<ErrorCode, String>() {{
      put(ErrorCode.io, "ERROR_CODE_IO");
      put(ErrorCode.inet_missing, "ERROR_CODE_INET_MISSING");
      put(ErrorCode.need_non_ui_thread, "ERROR_CODE_UI_THREAD");
      put(ErrorCode.checkout_canseled, "ERROR_CODE_CHECKOUT_CANCELED");
      put(ErrorCode.need_permission, "ERROR_CODE_NEED_PERMISSION");

    }};
  }

  public void setPrivateKey(String privateKey) {
    this.privateKey = privateKey;
  }

  public void setType(String type) {
    this.type = type;
  }

  @Override
  protected void onDraw(Canvas canvas) {
    super.onDraw(canvas);

    if (!this.isPresented) {
      switch (this.type) {
        case "checkout":
          LiqPay.checkout(context.getApplicationContext(), params, privateKey, this);
          break;
        case "checkoutBase64":
          LiqPay.checkout(context.getApplicationContext(), paramsBase64, signature, this);
          break;
        case "api":
          LiqPay.api(context.getApplicationContext(), path, params, privateKey, this);
          break;
        case "apiBase64":
          LiqPay.api(context.getApplicationContext(), path, paramsBase64, signature, this);
          break;
      }
      this.isPresented = true;
    }
  }

  @Override
  public void onResponseSuccess(final String data, final String signature) {
    WritableMap event = Arguments.createMap();

    try {
      JSONObject responseJSON = new JSONObject(data);

      if("failure".equals(responseJSON.optString("status"))) {
        if("cancel".equals(responseJSON.optString("err_code"))) {
          event.putString("error", this.errorCodeNames.get(ErrorCode.checkout_canseled));
        }
        else {
          event.putString("error", this.errorCodeNames.get(ErrorCode.io));
        }

        event.putString("message", responseJSON.optString("err_description"));
        this.triggerReactEvent("liqpayError", event);
      }
      else {
        event.putString("data", data);
        event.putString("signature", signature);

        this.triggerReactEvent("liqpaySuccess", event);
      }
    } catch (JSONException e) {
      event.putString("error", this.errorCodeNames.get(ErrorCode.io));
      event.putString("message", e.getMessage());

      this.triggerReactEvent("liqpayError", event);
    }
  }

  @Override
  public void onResponceError(final ErrorCode errorCode) {
    WritableMap event = Arguments.createMap();
    event.putString("error", this.errorCodeNames.get(errorCode));

    this.triggerReactEvent("liqpayError", event);
  }

  private void triggerReactEvent(String eventName, WritableMap event) {
    ReactContext reactContext = (ReactContext) getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
      getId(),
      eventName,
      event);
  }

  public void setParamsBase64(String paramsBase64) {
    this.paramsBase64 = paramsBase64;
  }

  public void setSignature(String signature) {
    this.signature = signature;
  }

  public void setPath(String path) {
    this.path = path;
  }

  public void setParams(HashMap<String, String> params) {
    this.params = params;
  }
}