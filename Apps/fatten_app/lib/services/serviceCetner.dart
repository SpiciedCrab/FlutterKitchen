import 'package:meta/meta.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

abstract class JSONConvertable {

  static JSONConvertable formJson(Map<String,dynamic> map) {
    return null;
  }

  static Map<String,dynamic> toJson(){
    return null;
  }
}

enum RequestMethod {
  get,
  post,
  put,
  delete,
}

class ServiceCenter {

  static Future<Map> request(String url, Map para , RequestMethod method) async {

    String errorMsg;
    int errorCode;
    var data;
    final headerMap = { "X-LC-Id": "gWc5lNCuBpIAj6hAnlJH3qFR-gzGzoHsz",
      "X-LC-Key": "Ttl6h5K78UpU5RlYiczIBSnQ",
      "Content-Type": "application/json"};

    http.Response res;


    switch (method) {
      case RequestMethod.get :
        res = await http.get(url, headers: headerMap);
        break;
      case RequestMethod.post :
        res = await http.post(url, headers: headerMap, body: json.encode(para));
        break;
      case RequestMethod.put :
        res = await http.put(url, headers: headerMap, body:  json.encode(para));
        break;
      case RequestMethod.delete :
        res = await http.delete(url, headers: headerMap);
        break;
    }

    if (res.statusCode != 200 && res.statusCode != 201) {
      errorMsg = "网络请求错误,状态码:"+res.statusCode.toString();
      throw new Exception("请求失败啦");
//        _handError(errorCallback, errorMsg);
//        return data;
    }

    final map = json.decode(res.body);
    return map;

//    try {
//
//    } catch (exception) {
//      print(exception);
//      _handError(errorCallback, exception.toString());
//    }
  }
}

