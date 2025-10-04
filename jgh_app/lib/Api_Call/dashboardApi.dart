import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Model/Dashboard_Model.dart';
import 'package:jgh_app/Util/AppConst.dart';


class DashboardApi_ApiCall {
  static Future<int> dashboardApi(BuildContext context) async{
    try{
      var url = Uri.parse(AppConst.dashboardUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
      });
      var response = await http.post(url,headers: headers, body: body);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        print(AppConst.authCode);
        print(AppConst.connectionId);
        if(data["status"]=="success"){
          DashboardModel.surveyPending = data["dashboard"]["survey_pending"].toString();
          DashboardModel.approvalPending = data["dashboard"]["approval_pending"].toString();
          DashboardModel.installationPending = data["dashboard"]["installation_pending"].toString();
          DashboardModel.installationCompleted = data["dashboard"]["installation_completed"].toString();
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}

