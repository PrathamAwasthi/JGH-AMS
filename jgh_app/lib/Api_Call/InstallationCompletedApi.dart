import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Model/InstallationCompletedModel.dart';
import 'package:jgh_app/Util/AppConst.dart';

import '../UI/InstallationCompleted.dart';

class InstallationCompletedApi_ApiCall {
  static Future<int> installationCompletedApiApi(BuildContext context, String page,{check = true}) async{
    try{
      var url = Uri.parse(AppConst.completedInstallationsUrl);
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
        "page": page,
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
      var response = await http.post(url, headers: headers, body: body);
      Navigator.pop(context);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        if(data["status"]=="success"){
          installationCompletedModelObject = [];
          for(int i=0;i<data["completed_installation_list"]["data"].length;i++){
            InstallationCompletedModel ob = InstallationCompletedModel(
              id: data["completed_installation_list"]["data"][i]["id"].toString(),
              status: data["completed_installation_list"]["data"][i]["status"].toString(),
              createdAt: data["completed_installation_list"]["data"][i]["created_at"].toString(),
              updatedAt: data["completed_installation_list"]["data"][i]["updated_at"].toString(),
              brandingElementName: data["completed_installation_list"]["data"][i]["branding_element_name"].toString(),
              dimensions: data["completed_installation_list"]["data"][i]["dimensions"],
              ownerName: data["completed_installation_list"]["data"][i]["owner_name"].toString(),
              shopName: data["completed_installation_list"]["data"][i]["shop_name"].toString(),
              statusLabel: data["completed_installation_list"]["data"][i]["status_label"].toString(),
              cost: data["completed_installation_list"]["data"][i]["cost"].toString(),
            );
            installationCompletedModelObject.add(ob);
          }
          InstallationCompletedModel.count = data["completed_installation_list"]["count"].toString();
          if(check){
            Navigator.push(context, MaterialPageRoute(builder: (context) => InstallationCompleted()));
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








