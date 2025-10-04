import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Api_Call/ImageUploadApi.dart';
import 'package:jgh_app/Api_Call/UploadInstallation.dart';
import 'package:jgh_app/Model/InstallationDetailModel.dart';
import 'package:jgh_app/Model/Profile_Model.dart';
import 'package:jgh_app/ScreenState/EnterOtpButton.dart';
import 'package:jgh_app/ScreenState/InstallationStatusPageState.dart';
import 'package:jgh_app/UI/UploadImages.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';


class RequestStatus extends StatefulWidget{
  State<StatefulWidget> createState(){
    return RequestStatusState();
  }
}

class RequestStatusState extends State<RequestStatus>{
  static bool uploadImage = false;
  static InstallationStatusPageState? requestProvider;
  String otp = "";

  Widget build(BuildContext context){

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.085),
        child: Container(
          color: Color(0xff273894),
          child: Container(
            height: height*0.085,
            width: width*0.8,
            color: Colors.transparent,
            child: Row(
              children: [
                IconButton(onPressed: (){ Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                Text("Installation Status", style: TextStyle(color: Colors.white, fontSize: 18),),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider<InstallationStatusPageState>(
        create: (context) => InstallationStatusPageState(),
        child: Consumer<InstallationStatusPageState>(
          builder: (context, pro, child){
            requestProvider = pro;
            return Container(
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
                    Container(
                      height: height*0.1,
                      width: width,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: height*0.03,
                                width: height*0.03,
                                decoration: BoxDecoration(
                                  color: Color(0xff198038),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.check,color: Colors.white, size: 12,),
                              ),
                              Container(
                                height: 1,
                                width: width*0.6,
                                color:installationDetailModelObject!.status == "2" ? Color(0xffF1C21B) : installationDetailModelObject!.status == "1" ? Color(0xffF1C21B) : Color(0xff198038),
                              ),
                              Container(
                                height: height*0.03,
                                width: height*0.03,
                                decoration: BoxDecoration(
                                  color:installationDetailModelObject!.status == "2" || installationDetailModelObject!.status == "1" ? Color(0xffF1C21B) :  Color(0xff198038),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(child: installationDetailModelObject!.status == "2" || installationDetailModelObject!.status == "1" ? Image.asset("assets/Icons.png",height: 32, color: Colors.black,) : Icon(Icons.check, color: Colors.white, size: 12,)),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Column(
                                children: [
                                  Text("Retailer request", style: TextStyle(fontSize: 12, color: Color(0xff198038)),),
                                ],
                              ),
                              Spacer(flex: 10,),
                              Column(
                                children: [
                                  Text(installationDetailModelObject!.status == "2" ? "Installation approvel" : "Installation request", style: TextStyle(fontSize: 12, color:installationDetailModelObject!.status == "2" || installationDetailModelObject!.status == "1" ? Color(0xffF1C21B) : Color(0xff198038),),),
                                  Text(installationDetailModelObject!.status == "2" ? "pending" : installationDetailModelObject!.status == "1" ? "Rejected" : "approvad", style: TextStyle(fontSize: 12, color:installationDetailModelObject!.status == "2" || installationDetailModelObject!.status == "1" ? Color(0xffF1C21B) : Color(0xff198038),),),
                                ],
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                    SizedBox(
                      height: installationDetailModelObject!.status == "2" ? height*0.46 : height*0.54,
                      width: width,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.01,width*0.7,0),
                              child: Container(
                                height: height*0.02,
                                width: width*0.15,
                                decoration: BoxDecoration(
                                  color: Color(0xffEBEEFF),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(child: Text("Req#0${installationDetailModelObject!.id}", style: TextStyle(fontSize: 10, color: Colors.deepPurpleAccent),)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                              child: Container(
                                width:width,
                                color: Colors.transparent,
                                child: Text("${installationDetailModelObject!.ownerName}", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,0,width*0.6,0),
                              child: Text("${installationDetailModelObject!.createdAt}", style: TextStyle(fontSize: 12, color: Colors.grey),overflow: TextOverflow.ellipsis),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 1,
                                width: width,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                              child: Row(
                                children: [
                                  Image.asset("assets/iconoir_shop.png", scale: 0.8,),
                                  Text(" ${installationDetailModelObject!.shopName}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: width*0.55,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on_outlined, color: Colors.grey,),
                                            Text(" ${installationDetailModelObject!.city}", style: TextStyle(fontSize: 14,),),
                                          ],
                                        ),
                                      ),
                                      color: Colors.transparent,
                                    ),
                                    Container(
                                      width: width*0.5,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Icon(Icons.phone, color: Colors.grey,),
                                            Text("+91 ${installationDetailModelObject!.mobileNumber}", style: TextStyle(fontSize: 14,),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,height*0.02,0,0),
                                  child: Container(
                                    height: height*0.1,
                                    width: width*0.4,
                                    color: Colors.transparent,
                                    child: Center(child: Image.network("https://beta.jghmagic.com/"+installationDetailModelObject!.locationImage,)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.025,0,0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 1,
                                    width: width*0.2,
                                    color: Colors.grey.shade400,
                                  ),
                                  Text("Request Approval Summary", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                  Container(
                                    height: 1,
                                    width: width*0.2,
                                    color: Colors.grey.shade400,
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0,8,8,0),
                                      child: Row(
                                        children: [
                                          Text("Element: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                          Container(
                                            width: width*0.3,
                                            child: Text("${installationDetailModelObject!.brandingElementName}", style: TextStyle(fontSize: 14, color: Colors.grey), overflow: TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(width*0.05,8,8,0),
                                      child: Row(
                                        children: [
                                          Text("Dimension: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                          Container(
                                            width: width*0.3,
                                            child: Text(" ${installationDetailModelObject!.dimensions["width"]} W x ${installationDetailModelObject!.dimensions["height"]} H", style: TextStyle(fontSize: 14, color: Colors.grey), overflow: TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(width*0.04,8,8,0),
                                      child: Row(
                                        children: [
                                          Text("Cost Total: ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                          Container(
                                            width: width*0.3,
                                            color: Colors.transparent,
                                            child: Text(" ${installationDetailModelObject!.cost}", style: TextStyle(fontSize: 14, color: Colors.grey), overflow: TextOverflow.ellipsis,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,height*0.02,0,0),
                                  child: Container(
                                    height: height*0.1,
                                    width: width*0.4,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: installationDetailModelObject!.surveyImages.length,
                                      itemBuilder: (context, int index){
                                        return Image.network("${installationDetailModelObject!.surveyImages[0]}", height: height*0.1, width: width*0.4,);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            installationDetailModelObject!.status == "3" ? Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: height*0.05,
                                    width: width*0.42,
                                    child: uploadImage ? Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.check_circle, color: Color(0xff198038), size: 24,),
                                          Text("Image Uploaded", style: TextStyle(color: Color(0xff198038), fontSize: 14),),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                    ) :
                                    ElevatedButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImages()));
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.photo_outlined, color: Colors.white, size: 24,),
                                          Text("Upload Image", style: TextStyle(color: Colors.white, fontSize: 14),),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        backgroundColor: Color(0xff006BD8),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    height: height*0.05,
                                    width: width*0.42,
                                    child: ElevatedButton(
                                      onPressed: uploadImage ? () async{
                                        otp = "";
                                        showDialog(
                                          context: context,
                                          builder: (context){
                                            return ChangeNotifierProvider<EnterOtpButton>(
                                              create: (context) => EnterOtpButton(),
                                              child: Consumer<EnterOtpButton>(
                                                builder: (context, provider, child){
                                                  return AlertDialog(
                                                    backgroundColor: Colors.white,
                                                    content: Container(
                                                      height: height*0.3,
                                                      width: width,
                                                      color: Colors.white,
                                                      child: Column(
                                                        children: [
                                                          Text("Verification Code", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                                          Text("Please enter OTP to", style: TextStyle(color: Colors.grey,),),
                                                          Text("continue", style: TextStyle(color: Colors.grey,),),
                                                          Text("+91 ${ProfileData.phone}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: PinCodeTextField(
                                                              appContext: context,
                                                              length: 4, // OTP digits
                                                              onChanged: (value) {
                                                                otp = value.trim().toString();
                                                                provider.updateState();
                                                              },
                                                              onCompleted: (value) {
                                                                otp = value.trim().toString();
                                                                provider.updateState();
                                                              },
                                                              hintCharacter: "-",
                                                              keyboardType: TextInputType.number,
                                                              pinTheme: PinTheme(
                                                                shape: PinCodeFieldShape.box,
                                                                borderRadius: BorderRadius.circular(width),
                                                                fieldHeight: 40,
                                                                fieldWidth: 30,
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
                                                          SizedBox(
                                                            height: height*0.05,
                                                            width: width*0.8,
                                                            child: ElevatedButton(
                                                              onPressed: otp.length == 4 ? () async{
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
                                                                  return;
                                                                }
                                                                showDialog(context: context, builder: (context){
                                                                  return AlertDialog(
                                                                    backgroundColor: Colors.transparent,
                                                                    content: Container(
                                                                      color: Colors.transparent,
                                                                      child: Center(child: CircularProgressIndicator(color: Colors.white,),),
                                                                    ),
                                                                  );
                                                                });
                                                                int n = await UploadInstallationApi_ApiCall.uploadInstallationApi(context, installationDetailModelObject!.id, otp, imagesUrl2.toString());
                                                                if(n==0){
                                                                  imagesUrl = [];
                                                                  imagesUrl2 = [];
                                                                  uploadImage = false;
                                                                  otp = "";
                                                                }else{
                                                                  otp = "";
                                                                  Navigator.pop(context);
                                                                }
                                                              } : null,
                                                              child: Text("Ok", style: TextStyle(color: Colors.white, fontSize: 16),),
                                                              style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10),
                                                                  ),
                                                                  backgroundColor: Color(0xff006BD8)
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      } : null,
                                      child: Row(
                                        children: [
                                          Text("Enter OTP", style: TextStyle(color: Colors.white, fontSize: 14),),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        backgroundColor: Color(0xff006BD8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ) : Text(""),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,installationDetailModelObject!.status == "2" ? height*0.15 : height*0.1,0,0),
                      child: SizedBox(
                        height: height*0.06,
                        width: width*0.8,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.popUntil(context, (root) => root.isFirst);
                          },
                          child: Text("Back to Home",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff006BD8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}



