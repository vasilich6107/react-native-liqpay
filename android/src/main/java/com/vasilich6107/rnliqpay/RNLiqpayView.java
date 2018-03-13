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
import ua.privatbank.paylibliqpay.LiqPay;
import ua.privatbank.paylibliqpay.LiqPayCallBack;

class RNLiqpayView extends View implements LiqPayCallBack {
  private Context context = null;
  private String privateKey = null;
  private String type = null;
  private String signature = null;
  private String paramsBase64 = null;
  private Boolean isPresented = false;
  private String path;
  private HashMap<String, String> params;

  public RNLiqpayView(Context context) {
    super(context);
    this.context = context;
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

    if(!this.isPresented) {
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
  public void onResponseSuccess(final String response) {
    try {
      JSONObject responseJSON = new JSONObject(response);
      JSONObject formattedJSON = new JSONObject();

      formattedJSON.put("data", responseJSON.toString());
      formattedJSON.put("signature", responseJSON.getString("signature"));

      WritableMap event = Arguments.createMap();
      event.putString("response", formattedJSON.toString());
      ReactContext reactContext = (ReactContext)getContext();
      reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
        getId(),
        "liqpaySuccess",
        event);
    } catch (JSONException e) {
      this.onResponceError(ErrorCode.io);
    }
  }

  @Override
  public void onResponceError(final ErrorCode errorCode) {
    Map<ErrorCode, String> errorCodeNames = new HashMap<ErrorCode, String>(){{
      put(ErrorCode.io, "ERROR_CODE_IO");
      put(ErrorCode.inet_missing, "ERROR_CODE_INET_MISSING");
      put(ErrorCode.need_non_ui_thread, "ERROR_CODE_UI_THREAD");
      put(ErrorCode.checkout_canseled, "ERROR_CODE_CHECKOUT_CANCELED");
      put(ErrorCode.need_permission, "ERROR_CODE_NEED_PERMISSION");

    }};

    WritableMap event = Arguments.createMap();
    event.putString("error", errorCodeNames.get(errorCode));
    ReactContext reactContext = (ReactContext)getContext();
    reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
      getId(),
      "liqpayError",
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