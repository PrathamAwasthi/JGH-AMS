import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Api_Call/ImageUploadApi.dart';
import 'package:jgh_app/Api_Call/getInstallationOtp.dart';
import 'package:jgh_app/Model/InstallationDetailModel.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';


class UploadImages extends StatefulWidget{
  State<StatefulWidget> createState(){
    return UploadImagesState();
  }
}

class UploadImagesState extends State<UploadImages>{

  List<File>? images = [];
  File? image;
  int i=0;
  var key = GlobalKey();
  int? imageWidth;
  int? imageHeight;
  Map<String, dynamic> heightWidth = {};

  Future<int> imagePick() async{
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
      return 1;
    }
    final XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
    if(file!=null){
      images!.add(File(file.path));
      imageSelect(images!.length-1);
      setState(() {});
      imageWidthAndHeight(images!.length-1);
      return 0;
    }
    return 1;
  }

  void imageSelect(int index){
    image = images![index];
    i = index;
    setState(() {});
  }

  void imageWidthAndHeight(int index){
    Image image = Image.file(images![index]);
    ImageStream stream = image.image.resolve(ImageConfiguration());
    stream.addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        print('Width: ${info.image.width}');
        print('Height: ${info.image.height}');
        imageWidth = info.image.width;
        imageHeight = info.image.height;
      }),
    );
  }

  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child:Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0,height*0.2,0,0),
                  child: Container(
                    height: height*0.3,
                    width: width*0.9,
                    decoration: const BoxDecoration(
                      border: DashedBorder.fromBorderSide(
                        dashLength: 10,
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: image != null ? Image.file(image!) : Text(""),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    height: height*0.1,
                    width: width,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: height*0.1,
                          width: width*0.8,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: images!.length,
                            itemBuilder: (context, int index){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: (){
                                    imageSelect(index);
                                  },
                                  child: Container(
                                    height: height*0.05,
                                    width: width*0.2,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: i == index ? Colors.lightBlueAccent : Colors.white,
                                        width: 2,
                                      ),
                                    ),
                                    child: images != null ? Image.file(images![index]) : Text(""),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        IconButton(onPressed: () async{
                          await imagePick();
                          setState(() {});
                        }, icon: Icon(Icons.add_a_photo_outlined, size: 32,),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0,height*0.15,0,0),
                  child: SizedBox(
                    height: height*0.06,
                    width: width*0.9,
                    child: ElevatedButton(
                        onPressed: images!.isEmpty ? () async{
                          await imagePick();
                        } : () async{
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
                          for(int i=0;i<images!.length;i++){
                            await ImageUploadApi_ApiCall.imageUploadApi(context, images![i]);
                          }
                          Navigator.pop(context);
                          await GetInstallationApi_ApiCall.getInstallationApi(context, installationDetailModelObject!.id, installationDetailModelObject!.mobileNumber);
                        },
                        child: Text(images!.isEmpty ? "Take Picture" : "Save Image", style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color(0xff006BD8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}






