import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Model/BankAccountListModel.dart';
import 'package:jgh_app/Util/AppConst.dart';

import '../UI/BankAccount.dart';


class BankAccountList_ApiCall {
  static Future<int> bankAccountListApi(BuildContext context, {bool check = true}) async{
    try{
      var url = Uri.parse(AppConst.bankAccountListUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
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
          fontSize: 16.0,
        );
        Navigator.pop(context);
        return 1;
      }
      var response = await http.post(url,headers: headers, body: body);
      Navigator.pop(context);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        print(AppConst.authCode);
        print(AppConst.connectionId);
        if(data["status"]=="success"){
          bankAccountListModelObjects = [];
          for(int i=0;i<data["bank_account_list"].length;i++){
            BankAccountListModel ob = BankAccountListModel(
                id: data["bank_account_list"][i]["id"].toString(),
                vendorId: data["bank_account_list"][i]["vendor_id"].toString(),
                bankName: data["bank_account_list"][i]["bank_name"].toString(),
                accountHolderName: data["bank_account_list"][i]["account_holder_name"].toString(),
                accountNumber: data["bank_account_list"][i]["account_number"].toString(),
                ifscCode: data["bank_account_list"][i]["ifsc_code"].toString(),
                upiId: data["bank_account_list"][i]["upi_id"].toString(),
                isPrimary: data["bank_account_list"][i]["is_primary"].toString(),
                createdAt: data["bank_account_list"][i]["created_at"].toString(),
                updatedAt: data["bank_account_list"][i]["updated_at"].toString(),
                deletedAt: data["bank_account_list"][i]["deleted_at"].toString(),
            );
            bankAccountListModelObjects.add(ob);
          }
          print(bankAccountListModelObjects.length);
          if(check){
            Navigator.push(context, MaterialPageRoute(builder: (context) => BankAccount()));
          }
        }
      }
    } catch(e){
      return 1;
    }
    return 0;
  }
}

