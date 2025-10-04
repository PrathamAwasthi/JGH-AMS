import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jgh_app/Api_Call/postOtp.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPPage extends StatefulWidget{
  String phoneNo;
  OTPPage(this.phoneNo, {super.key});
  State<StatefulWidget> createState(){
    return OTPPageState();
  }
}

class OTPPageState extends State<OTPPage>{
  bool isChecked = true;
  bool isChecked2 = true;
  bool checkNo = false;
  String? otpNo;

  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
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
                padding: EdgeInsets.fromLTRB(0,height*0.07,0,0),
                child: Image.asset("assets/computer-security-with-login-password-padlock 1.png"),
              ),
              Text("Verification code", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Padding(
                padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                child: Row(
                  children: [
                    Text("+91 ${widget.phoneNo} ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.edit,size: 16,),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(width*0.08,width*0.08,width*0.08,0),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4, // OTP digits
                  onChanged: (value) {
                    otpNo = value.trim().toString();
                    print("OTP changed: $value");
                    if(value.length == 4){
                      checkNo = true;
                      setState(() {});
                    }else{
                      checkNo = false;
                      setState(() {});
                    }
                  },
                  onCompleted: (value) {
                    otpNo = value.trim().toString();
                    print("OTP entered: $value");
                    if(value.length == 4){
                      checkNo = true;
                      setState(() {});
                    }
                  },
                  hintCharacter: "-",
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(width),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    inactiveColor: Colors.grey,
                    activeColor: Colors.white,
                    selectedColor: Colors.blueAccent,
                  ),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  enableActiveFill: true,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(width*0.1,0,0,0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            if(isChecked){
                              isChecked = false;
                            }else{
                              isChecked = true;
                            }
                            setState(() {});
                          },
                          icon: isChecked ? Icon(Icons.check_box_outlined) : Icon(Icons.check_box_outline_blank),
                        ),
                        Text("I agree to the JGH terms & conditions", style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            if(isChecked2){
                              isChecked2 = false;
                            }else{
                              isChecked2 = true;
                            }
                            setState(() {});
                          },
                          icon: isChecked2 ? Icon(Icons.check_box_outlined) : Icon(Icons.check_box_outline_blank),
                        ),
                        Text("Send me offer", style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height*0.06,
                width: width*0.8,
                child: ElevatedButton(
                    onPressed: checkNo && isChecked2 && isChecked ? () async{
                      await PostOtp_ApiCall.postOtp(context, widget.phoneNo, otpNo!);
                    } : null,
                    child: Text("Verify", style: TextStyle(color: checkNo ? Colors.white : Colors.grey, fontSize: 16),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff006BD8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

