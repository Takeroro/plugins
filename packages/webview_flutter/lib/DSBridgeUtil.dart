import 'dart:convert';

import 'package:webview_flutter/webview_flutter.dart';

class DSBridgeUtil {
  static String dsCallbackString(
      {WebViewController webController,
      bool completed,
      dynamic data,
      String callback}) {
    String del = '';

    Map<String, dynamic> dataMap = Map<String, dynamic>();
    dataMap['code'] = 0;

    if (data != null) {
      dataMap['data'] = data;
    }

    String value = json.encode(dataMap);

    value = Uri.encodeFull(value);

    if (value == null) {
      value = '';
    }
    if (callback == null) {
      callback = '';
    }

    if (completed) {
      del = "delete window." + callback;
    }
    String ret =
        "try {$callback(JSON.parse(decodeURIComponent(\"$value\")).data);$del; } catch(e){};";
    webController.evaluateJavascript(ret);
    
    return ret;
  }
}
