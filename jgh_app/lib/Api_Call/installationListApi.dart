import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Model/InstallationListModel.dart';
import 'package:jgh_app/Util/AppConst.dart';

class InstallationListApi_ApiCall {
  static Future<int> installationListApi(BuildContext context, String status) async{
    try{
      var url = Uri.parse(AppConst.installationListUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
        "status": status,
      });
      var response = await http.post(url, headers: headers, body: body);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"]=="success"){
          installationListModelObject = [];
          for(int i=0;i<data["installation_list"]["data"].length;i++){
            InstallationListModel ob = InstallationListModel(
                id: data["installation_list"]["data"][i]["id"].toString(),
                status: data["installation_list"]["data"][i]["status"].toString(),
                createdAt: data["installation_list"]["data"][i]["created_at"].toString(),
                updatedAt: data["installation_list"]["data"][i]["updated_at"].toString(),
                brandingElementName: data["installation_list"]["data"][i]["branding_element_name"].toString(),
                dimensions: data["installation_list"]["data"][i]["dimensions"],
                surveyImages: data["installation_list"]["data"][i]["survey_images"],
                ownerName: data["installation_list"]["data"][i]["owner_name"].toString(),
                shopName: data["installation_list"]["data"][i]["shop_name"].toString(),
                statusLabel: data["installation_list"]["data"][i]["status_label"].toString(),
                cost: data["installation_list"]["data"][i]["cost"].toString(),
            );
            installationListModelObject.add(ob);
          }
          return 0;
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}








