import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Api_Call/BankAccountList.dart';
import 'package:jgh_app/UI/BankAccount.dart';
import 'package:jgh_app/Util/AppConst.dart';



class AddBankAccount_ApiCall {
  static Future<int> addBankAccountApi(BuildContext context, { required String accountHolderName, required String bankName, required String accountNumber, String upi_Id = "", required String ifscCode}) async{
    try{
      var url = Uri.parse(AppConst.bankAccountAddUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = jsonEncode({
        "connection_id": AppConst.connectionId,
        "auth_code": AppConst.authCode,
        "bank_name": bankName,
        "account_holder_name": accountHolderName,
        "account_number": accountNumber,
        "ifsc_code": ifscCode,
        "upi_id": upi_Id,
        "is_primary": "0",
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
      print(response.statusCode);
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        print(data);
        print(AppConst.authCode);
        print(AppConst.connectionId);
        if(data["status"]=="success"){
          Fluttertoast.showToast(
            msg: "Bank Account Added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          await BankAccountList_ApiCall.bankAccountListApi(context, check: false);
          Navigator.pop(context);
        }else if(data["status"]=="error"){
          if(data["message"]=="Something went wrong: The account number has already been taken."){
            Fluttertoast.showToast(
              msg: "The account number has already exist",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            return 0;
          }
          Fluttertoast.showToast(
            msg: "Please enter valid information",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } catch(e){
      return 1;
    }
    return 0;
  }
}

