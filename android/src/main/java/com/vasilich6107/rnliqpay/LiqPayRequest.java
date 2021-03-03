package com.vasilich6107.rnliqpay;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;

import ua.privatbank.paylibliqpay.LogUtil;

class LiqPayRequest {
    static String post(String url, Map<String, String> list) throws IOException {
        String postData = "";

        for (Map.Entry<String, String> entry : list.entrySet()) {
            //for (Iterator<Map.Entry<String, String>> var3 = list.entrySet().iterator(); var3.hasNext());
            //  Map.Entry entry = var3.next();
            postData = postData + (String) entry.getKey() + "=" + URLEncoder.encode((String) entry.getValue(), "UTF-8") + "&";
            URL obj = new URL(url);
            BufferedReader in = null;
            HttpURLConnection conn = null;
            try {
                LogUtil.log("==== req:" + url + "   data: " + postData);
                conn = (HttpURLConnection) obj.openConnection();
                conn.setRequestMethod("POST");
                conn.setDoOutput(true);
                DataOutputStream wr = new DataOutputStream(conn.getOutputStream());
                wr.writeBytes(postData);
                wr.flush();
                wr.close();
                in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                StringBuilder response = new StringBuilder();
                String inputLine;
                while ((inputLine = in.readLine()) != null)
                    response.append(inputLine);
                LogUtil.log("==== resp:" + response.toString());
                String var9 = response.toString();
                return var9;
            } finally {
                if (in != null)
                    in.close();
                if (conn != null)
                    conn.disconnect();
            }
        }
        return postData;
    }
}