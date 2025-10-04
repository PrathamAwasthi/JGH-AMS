import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Model/InstallationDetailModel.dart';
import 'package:jgh_app/Util/AppConst.dart';

class InstallationDetailApi_ApiCall {
  static Future<int> installationDetailApi(BuildContext context, String id) async{

    try{
      var url = Uri.parse(AppConst.installationDetailUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
        "request_id": id,
      });
      var response = await http.post(url, headers: headers, body: body);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"]=="success"){
          installationDetailModelObject = InstallationDetailModel(
              id: data["installation_detail"]["id"].toString(),
              status: data["installation_detail"]["status"].toString(),
              createdAt: data["installation_detail"]["created_at"].toString(),
              updatedAt: data["installation_detail"]["updated_at"].toString(),
              brandingElementName: data["installation_detail"]["branding_element_name"].toString(),
              dimensions: data["installation_detail"]["dimensions"],
              surveyImages: data["installation_detail"]["survey_images"],
              ownerName: data["installation_detail"]["owner_name"].toString(),
              countryCode: data["installation_detail"]["country_code"].toString(),
              mobileNumber: data["installation_detail"]["mobile_number"].toString(),
              shopName: data["installation_detail"]["shop_name"].toString(),
              city: data["installation_detail"]["city"].toString(),
              locationImage: data["installation_detail"]["location_image"].toString(),
              cost: data["installation_detail"]["cost"].toString(),
              quantity: data["installation_detail"]["quantity"].toString(),
              canUpload: data["installation_detail"]["can_upload"].toString(),
              statusLabel: data["installation_detail"]["status_label"].toString(),
          );
          return 0;
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }

}









