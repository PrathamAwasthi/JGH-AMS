import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Util/AppConst.dart';

import '../UI/Dashboard.dart';

class UploadSurvey_ApiCall {
  static Future<int> uploadSurveyApi(BuildContext context, String images, Map dimensions, String requestId) async{

    try{
      var url = Uri.parse(AppConst.uploadSurveyUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
        "request_id": requestId,
        "dimensions": "{${'"'}width${'"'}:${dimensions["width"].toString()},${'"'}height${'"'}:${dimensions["height"].toString()}}",
        "images": images,
      });
      print("Body data=${body}");
      var response = await http.post(url, headers: headers, body: body);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"]=="success"){
          return 0;
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }

}









