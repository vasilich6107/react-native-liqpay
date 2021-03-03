package com.vasilich6107.rnliqpay;
//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

import android.annotation.SuppressLint;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Looper;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import org.json.JSONObject;

import ua.privatbank.paylibliqpay.CheckoutActivity;
import ua.privatbank.paylibliqpay.ErrorCode;
import ua.privatbank.paylibliqpay.LiqPayCallBack;
import com.vasilich6107.rnliqpay.LiqPayRequest;
import com.vasilich6107.rnliqpay.LiqPayUtil;

public class LiqPay {
    private Context context;
    private LiqPayCallBack checkoutCallBack;
    private BroadcastReceiver mReceiver = new BroadcastReceiver() {
        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals("ua.privatbank.paylibliqpay.broadcast") && LiqPay.this.checkoutCallBack != null) {
                String data = intent.getStringExtra("data");
                String signature = intent.getStringExtra("signature");
                if (data == null) {
                   LiqPay.this.checkoutCallBack.onResponceError(ErrorCode.checkout_canseled);
                } else {
                    LiqPay.this.checkoutCallBack.onResponseSuccess(data, signature);
                }

                context.unregisterReceiver(this);
            }

        }
    };

    private LiqPay(Context applicationContext, LiqPayCallBack checkoutCallBack) {
        this.context = applicationContext;
        this.checkoutCallBack = checkoutCallBack;
    }

    public static void api(Context context, String path, HashMap<String, String> params, String privateKey, LiqPayCallBack callBack) {
        String base64Data = LiqPayUtil.base64Encode((new JSONObject(params)).toString());
        String signature = LiqPayUtil.createSignature(base64Data, privateKey);
        api(context, path, base64Data, signature, callBack);
    }

    public static void api(Context context, String path, String base64Data, String signature, LiqPayCallBack callBack) {
        if (!LiqPayUtil.checkPermissions(context, new String[]{"android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})) {
            callBack.onResponceError(ErrorCode.need_permission);
        } else if (!LiqPayUtil.isOnline(context)) {
            callBack.onResponceError(ErrorCode.inet_missing);
        } else if (Looper.myLooper() == Looper.getMainLooper()) {
            callBack.onResponceError(ErrorCode.need_non_ui_thread);
        } else {
            HashMap<String, String> postParams = new HashMap();
            postParams.put("data", base64Data);
            postParams.put("signature", signature);

            try {
                String resp = LiqPayRequest.post(LiqPayUtil.LIQPAY_API_URL_REQUEST + path, postParams);
                callBack.onResponseSuccess(resp, "");
            } catch (IOException var7) {
                var7.printStackTrace();
                callBack.onResponceError(ErrorCode.io);
            }
        }

    }

    public static void checkout(Context context, HashMap<String, String> params, String privateKey, LiqPayCallBack callBack) {
        String base64Data = LiqPayUtil.base64Encode((new JSONObject(params)).toString());
        String signature = LiqPayUtil.createSignature(base64Data, privateKey);
        checkout(context, base64Data, signature, callBack);
    }

    public static void checkout(Context context, String base64Data, String signature, LiqPayCallBack callBack) {
        if (!LiqPayUtil.checkPermissions(context, new String[]{"android.permission.READ_PHONE_STATE", "android.permission.INTERNET", "android.permission.ACCESS_NETWORK_STATE"})) {
            callBack.onResponceError(ErrorCode.need_permission);
        } else if (!LiqPayUtil.isOnline(context)) {
            callBack.onResponceError(ErrorCode.inet_missing);
        } else {
            LiqPay liqPay = new LiqPay(context, callBack);
            context.registerReceiver(liqPay.mReceiver, new IntentFilter("ua.privatbank.paylibliqpay.broadcast"));
            liqPay.startCheckoutActivity(base64Data, signature);
        }

    }

    @SuppressLint("WrongConstant")
    private void startCheckoutActivity(String data, String signature) {
        Intent intent = new Intent(this.context, CheckoutActivity.class);
        intent.putExtra("postData", "data=" + URLEncoder.encode(data) + "&signature=" + signature + "&hash_device=" + LiqPayUtil.getHashDevice(this.context) + "&channel=android");
        intent.addFlags(268435456);
        this.context.startActivity(intent);
    }
}
