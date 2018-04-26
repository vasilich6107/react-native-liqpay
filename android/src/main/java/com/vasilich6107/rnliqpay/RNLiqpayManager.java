package com.vasilich6107.rnliqpay;

import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.common.MapBuilder;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

public class RNLiqpayManager extends SimpleViewManager<RNLiqpayView> {
  @Nullable
  @Override
  public Map<String, Object> getExportedCustomBubblingEventTypeConstants() {
    return new HashMap<String, Object>() {{
      put(
        "liqpaySuccess",
        MapBuilder.of(
          "phasedRegistrationNames",
          MapBuilder.of("bubbled", "onLiqpaySuccess")));
      put(
        "liqpayError",
        MapBuilder.of(
          "phasedRegistrationNames",
          MapBuilder.of("bubbled", "onLiqpayError")));
    }};
  }

  @Override
  public RNLiqpayView createViewInstance(ThemedReactContext context) {
    return new RNLiqpayView(context);
  }

  @ReactProp(name = "privateKey")
  public void setPrivateKey(RNLiqpayView view, String privateKey) {
    view.setPrivateKey(privateKey);
  }

  @ReactProp(name = "type")
  public void setType(RNLiqpayView view, String type) {
    view.setType(type);
  }

  @ReactProp(name = "paramsBase64")
  public void setParamsBase64(RNLiqpayView view, String paramsBase64) {
    view.setParamsBase64(paramsBase64);
  }

  @ReactProp(name = "signature")
  public void setSignature(RNLiqpayView view, String signature) {
    view.setSignature(signature);
  }

  @ReactProp(name = "path")
  public void setPath(RNLiqpayView view, String path) {
    view.setPath(path);
  }

  @ReactProp(name = "params")
  public void setPath(RNLiqpayView view, ReadableMap params) {
    HashMap<String, String> map = new HashMap<>();
    for (HashMap.Entry<String, Object> entry : params.toHashMap().entrySet()) {
      map.put(entry.getKey(), String.valueOf(entry.getValue()));
    }
    view.setParams(map);
  }

  @Override
  public String getName() {
    return "RNLiqpay";
  }
}
