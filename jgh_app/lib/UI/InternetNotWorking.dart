import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/UI/Dashboard.dart';


class InternetNotWorking extends StatefulWidget{
  State<StatefulWidget> createState(){
    return InternetNotWorkingState();
  }
}

class InternetNotWorkingState extends State<InternetNotWorking>{

  Future<int> checkInternet() async{
    final bool isConnected = await InternetConnection().hasInternetAccess;
    if(isConnected){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
    }else{
      Fluttertoast.showToast(
          msg: "Please Check Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    return 0;
  }

  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("Please Check Internet Connection", style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold),),
              FutureBuilder(future: checkInternet(), builder: (context, snapshot){
                if(snapshot.connectionState.toString() == "ConnectionState.done"){
                  return ElevatedButton(
                    onPressed: () async{
                      checkInternet();
                      setState(() {});
                    },
                    child: Text("Retry", style: TextStyle(color: Colors.black),),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Colors.amber,
                    ),
                  );
                }else{
                  return CircularProgressIndicator();
                }
              }),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}





