import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:jgh_app/Api_Call/ProfileEditApi.dart';
import 'package:jgh_app/Api_Call/profileApi.dart';
import 'package:jgh_app/Model/Profile_Model.dart';
import 'package:jgh_app/UI/ViewImage.dart';
import '../Util/AppConst.dart';

class Profile extends StatefulWidget{
  State<StatefulWidget> createState(){
    return ProfileState();
  }
}

class ProfileState extends State<Profile>{

  TextEditingController profileName = TextEditingController();
  TextEditingController aadhaarNo = TextEditingController();
  TextEditingController panCardNo = TextEditingController();
  TextEditingController shopName = TextEditingController();
  TextEditingController gstNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  File? image;
  String? imageNetwork;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilize();
  }

  void initilize(){
    profileName.text = ProfileData.name ?? "Empty";
    aadhaarNo.text = ProfileData.adharNumber ?? "Empty";
    panCardNo.text = ProfileData.pancard ?? "Empty";
    shopName.text = ProfileData.shopName ?? "Empty";
    gstNo.text = ProfileData.gstNumber ?? "Empty";
    address.text = ProfileData.address ?? "Empty";
    phoneNo.text = ProfileData.phone ?? "Empty";
  }

  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      child: RefreshIndicator(
          child: Column(
            children: [
              Container(
                height: height*0.22,
                width: width,
                decoration: BoxDecoration(
                  color: Color(0xff273894),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0,width*0.05,0),
                      child: Row(
                        children: [
                          Spacer(),
                          IconButton(
                            onPressed: () async{},
                            icon: Text(""),
                            splashColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,0,0,0),
                      child: Row(
                        children: [
                          Container(
                            height: height*0.14,
                            width: height*0.14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ViewImage(image: "http://ams.jghmagic.com/"+ProfileData.profileImage!)));
                                    },
                                    child: Container(
                                      height: height*0.12,
                                      width: height*0.12,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: ClipOval(
                                          child: image == null ? Image.network("http://ams.jghmagic.com/"+ProfileData.profileImage!,height: height*0.05, width: height*0.05, fit: BoxFit.cover,) : Image.file(image!,height: height*0.05, width: height*0.05, fit: BoxFit.cover,)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.2,height*0.095,0,0),
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      icon: Center(child: Icon(Icons.add_a_photo_outlined, size: 20,),),
                                      onPressed: () async{
                                        final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                                        if(file != null){
                                          image = File(file.path);
                                        }
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: width*0.55,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Icon(Icons.phone, color: Colors.white,),
                                    Text(" ${ProfileData.phone}", style: TextStyle(color: Colors.white, fontSize: 16), overflow: TextOverflow.ellipsis,),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                              ),
                              Container(
                                width: width*0.55,
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    Icon(Icons.mail, color: Colors.white,),
                                    Container(width:width*0.48,color: Colors.transparent,child: Text(" ${ProfileData.email}", style: TextStyle(color: Colors.white, fontSize: 16), overflow: TextOverflow.ellipsis,)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: width,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                          child: Row(
                            children: [
                              Container(
                                height: height*0.1,
                                width: width*0.95,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text("Profile Name", style: TextStyle(color: Color(0xff273894)),),
                                      TextField(
                                        controller: profileName,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade100,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          hintText: "${ProfileData.name}",
                                        ),
                                      ),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                          child: Container(
                            height: height*0.1,
                            width: width*0.95,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text("Aadhaar Number", style: TextStyle(color: Color(0xff273894)),),
                                  TextField(
                                    controller: aadhaarNo,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      hintText: "${ProfileData.adharNumber}",
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                          child: Container(
                            height: height*0.1,
                            width: width*0.95,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text("Pan Card* (Business)", style: TextStyle(color: Color(0xff273894)),),
                                  TextField(
                                    controller: panCardNo,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.shade100,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.grey),
                                        ),
                                        hintText: "${ProfileData.pancard}"
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                          child: Container(
                            height: height*0.18,
                            width: width*0.95,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text("Shop Name", style: TextStyle(color: Color(0xff273894)),),
                                  TextField(
                                    maxLengthEnforcement: MaxLengthEnforcement.enforced, // Forcefully enforce limit
                                    keyboardType: TextInputType.text,
                                    controller: shopName,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      hintText: "${ProfileData.shopName}",
                                      suffixIcon: Padding(
                                        padding: EdgeInsets.fromLTRB(0,0,width*0.05,0),
                                        child: Container(
                                          height: height*0.14,
                                          width: width*0.4,
                                          child: Image.network("http://ams.jghmagic.com/"+ProfileData.shopImage!),
                                        ),
                                      ),
                                    ),
                                    maxLines: 4,
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                          child: Container(
                            height: height*0.1,
                            width: width*0.95,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text("GST NO*", style: TextStyle(color: Color(0xff273894)),),
                                  TextField(
                                    controller: gstNo,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      hintText: "${ProfileData.gstDetail}",
                                    ),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                          child: Container(
                            height: height*0.15,
                            width: width*0.95,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text("Address", style: TextStyle(color: Color(0xff273894)),),
                                  TextField(
                                    keyboardType: TextInputType.text, // or TextInputType.name for addresses
                                    textInputAction: TextInputAction.done,
                                    controller: address,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      hintText: "${ProfileData.address}",
                                    ),
                                    maxLines: 3,
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                          child: Container(
                            height: height*0.1,
                            width: width*0.95,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text("Phone Number", style: TextStyle(color: Color(0xff273894)),),
                                  TextField(
                                    readOnly: true,
                                    controller: phoneNo,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      hintText: "${ProfileData.phone}",
                                      prefixIcon: Container(
                                        width: width*0.2,
                                        color: Colors.transparent,
                                        child: Row(
                                          children: [
                                            Text("+91", style: TextStyle(color: Color(0xff273894), fontSize: 16),),
                                            Icon(Icons.keyboard_arrow_down,color: Color(0xff273894),size: 28,),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.phone,
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async{
                            if(image!=null){
                              try{
                                var url = Uri.parse(AppConst.uploadImageUrl);
                                var headers = {
                                  'Content-Type': 'application/json',
                                };
                                final bytes = await image!.readAsBytes();
                                final base64Image = base64Encode(bytes);
                                print(base64Image);
                                var body = jsonEncode({
                                  "connection_id": AppConst.connectionId,
                                  "auth_code": AppConst.authCode,
                                  "image": "data:image/png;base64,$base64Image",
                                });

                                var response = await http.post(url, headers: headers, body: body);
                                print(response.statusCode);
                                print(base64Image);
                                if(response.statusCode == 200){
                                  final data = jsonDecode(response.body);
                                  print(data);
                                  if(data["status"]=="success"){
                                    print("ppppppppppppppppppppppppppppppppppppPP");
                                    print("ppppppppppppppppppppppppppppppppppppPP");
                                    imageNetwork = data["upload_image"]["path"];
                                  }
                                }
                              }catch(e){}
                            }
                            if(imageNetwork == null){
                              imageNetwork = ProfileData.profileImage!;
                            }
                            await EditProfile_ApiCall.editProfile(
                              context,
                              name: profileName.text.toString(),
                              phone: phoneNo.text.toString(),
                              email: ProfileData.email!,
                              panCard: panCardNo.text.toString(),
                              gst_number: gstNo.text.toString(),
                              shop_name: shopName.text.toString(),
                              address: address.text.toString(),
                              shop_image: ProfileData.shopImage!,
                              profile_image: imageNetwork!,
                              adhar_number: aadhaarNo.text.toString(),
                            );
                            await Profile_ApiCall.profileOtp(context);
                            image = null;
                            imageNetwork = null;
                            initilize();
                            setState(() {});
                          },
                          child: Text("Submit", style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            backgroundColor: Color(0xff273894),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          onRefresh: () async{
            await Profile_ApiCall.profileOtp(context);
            image = null;
            imageNetwork = null;
            initilize();
            setState(() {});
          }
      ),
    );
  }
}





