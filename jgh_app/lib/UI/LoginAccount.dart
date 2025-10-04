import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jgh_app/Api_Call/getConnectionApi.dart';

class LoginPage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage>{
  TextEditingController phoneNo = TextEditingController();
  bool checkNo = false;

  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              SystemNavigator.pop();
            },
            icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Padding(
          padding: EdgeInsets.fromLTRB(width*0.15,0,0,0),
          child: Text("Login Account", style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white,
            Color(0xffe6eeff),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0,height*0.12,0,0),
                child: Image.asset("assets/privacy-policy-concept-illustration 1.png"),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,height*0.12,width*0.2,0),
                child: Text("Get Started with Just Your Number", style: TextStyle(fontSize: 18, color: Colors.grey.shade500),),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: phoneNo,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(width),
                        topLeft: Radius.circular(width),
                        bottomRight: Radius.circular(width),
                        bottomLeft: Radius.circular(width),
                      ),
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(width),
                        topLeft: Radius.circular(width),
                        bottomRight: Radius.circular(width),
                        bottomLeft: Radius.circular(width),
                      ),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    hintText: "Enter your number",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    prefixIcon: Container(
                      height: height*0.065,
                      width: width*0.22,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(width),
                          bottomLeft: Radius.circular(width),
                        ),
                        border: Border.all(color: Colors.grey, width: 1)
                      ),
                      child: Row(
                        children: [
                          Text("+91", style: TextStyle(fontSize: 16),),
                          Icon(Icons.arrow_drop_down_outlined)
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
                  onChanged: (value){
                    if(value.length == 10){
                      checkNo = true;
                      setState(() {});
                    }
                    if(value.length<=9){
                      checkNo = false;
                      setState(() {});
                    }
                    if(11<=value.length){
                      final text = phoneNo.text;
                      if (text.isNotEmpty) {
                        phoneNo.text = text.substring(0, text.length - 1);
                        phoneNo.selection = TextSelection.fromPosition(
                          TextPosition(offset: phoneNo.text.length),
                        );
                      }
                      setState(() {});
                    }
                  },
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                child: SizedBox(
                  height: height*0.06,
                  width: width*0.9,
                  child: ElevatedButton(
                      onPressed: checkNo ? () async{
                        await GetConnectionId_ApiCall.getConnectionId(context, phoneNo.text.trim().toString());
                      } : null,
                      child: Text("Request OTP", style: TextStyle(fontSize: 18, color: checkNo ? Colors.white : Colors.grey),),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      backgroundColor: Color(0xff006BD8),
                    ),
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}

