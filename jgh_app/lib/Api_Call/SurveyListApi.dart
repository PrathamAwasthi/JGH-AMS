import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Model/SurveyList_Model.dart';
import 'package:jgh_app/Util/AppConst.dart';


class SurveyListApi_ApiCall {
  static Future<int> surveyListApi(BuildContext context) async{
    try{
      var url = Uri.parse(AppConst.surveyListUrl);
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
          surveyListModelObjects = [];
          for(int i=0;i<data["survey_list"]["data"].length;i++){
            SurveyListModel ob = SurveyListModel(
                userId: data["survey_list"]["data"][i]["user_id"].toString(),
                latestUpdatedAt: data["survey_list"]["data"][i]["latest_updated_at"].toString(),
                createdAt: data["survey_list"]["data"][i]["created_at"].toString(),
                ownerName: data["survey_list"]["data"][i]["owner_name"].toString(),
                countryCode: data["survey_list"]["data"][i]["country_code"].toString(),
                mobileNumber: data["survey_list"]["data"][i]["mobile_number"].toString(),
                shopName: data["survey_list"]["data"][i]["shop_name"].toString(),
                locationImage: data["survey_list"]["data"][i]["location_image"].toString(),
                city: data["survey_list"]["data"][i]["city"].toString(),
                stateName: data["survey_list"]["data"][i]["state_name"].toString(),
                address: data["survey_list"]["data"][i]["address"].toString(),
                pincode: data["survey_list"]["data"][i]["pincode"].toString(),
                brandingElements: data["survey_list"]["data"][i]["branding_elements"].toString(),
                statusLabel: data["survey_list"]["data"][i]["status_label"].toString(),
                latitude: data["survey_list"]["data"][i]["latitude"].toString(),
                longitude: data["survey_list"]["data"][i]["longitude"].toString(),
            );
            surveyListModelObjects.add(ob);
          }
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}






