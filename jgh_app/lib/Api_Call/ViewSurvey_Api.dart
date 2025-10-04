import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Model/ViewSurvey_Model.dart';
import 'package:jgh_app/UI/ViewSurvey.dart';
import 'package:jgh_app/Util/AppConst.dart';


class ViewSurvey_ApiCall {
  static Future<int> ViewSurveyApi(BuildContext context,{required String owner_id}) async{
    try{
      var url = Uri.parse(AppConst.surveyDetailUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
        "owner_id": owner_id,
      });
      showDialog(context: context, builder: (context){
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            color: Colors.transparent,
            child: Center(child: CircularProgressIndicator(color: Colors.white,),),
          ),
        );
      });
      final bool isConnected = await InternetConnection().hasInternetAccess;
      if(!isConnected){
        Fluttertoast.showToast(
            msg: "Please Check Internet Connection",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.pop(context);
        return 1;
      }
      var response = await http.post(url,headers: headers, body: body);
      Navigator.pop(context);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"]=="success"){
          viewSurveyModelObject = [];
          for(int i=0;i<data["survey_detail"].length;i++){
            ViewSurveyModel ob = ViewSurveyModel(
              id: data["survey_detail"][i]["id"].toString(),
              status: data["survey_detail"][i]["status"].toString(),
              createdAt: data["survey_detail"][i]["created_at"].toString(),
              updatedAt: data["survey_detail"][i]["updated_at"].toString(),
              brandingElementName: data["survey_detail"][i]["branding_element_name"].toString(),
              ownerName: data["survey_detail"][i]["owner_name"].toString(),
              mobileNumber: data["survey_detail"][i]["mobile_number"].toString(),
              shopName: data["survey_detail"][i]["shop_name"].toString(),
              statusLabel: data["survey_detail"][i]["status_label"].toString(),
            );
            viewSurveyModelObject.add(ob);
          }

          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSurveyPage()));
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}

