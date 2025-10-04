import 'dart:io';
import 'dart:math';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Api_Call/ImageUploadApi.dart';
import 'package:jgh_app/Api_Call/UploadServay.dart';
import 'package:jgh_app/Model/ViewSurvey_Model.dart';
import 'package:jgh_app/UI/Dashboard.dart';
import 'package:path_provider/path_provider.dart';


class ViewStatusPage extends StatefulWidget{
  int index;
  ViewStatusPage(this.index, {super.key});
  State<StatefulWidget> createState(){
    return ViewStatusPageState();
  }
}

class ViewStatusPageState extends State<ViewStatusPage>{

  List<File> images = [];
  File? image;
  int i=0;
  var key = GlobalKey();
  int? imageWidth;
  int? imageHeight;
  Map<String, dynamic> heightWidth = {};
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();


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
      images.add(File(file.path));
      imageSelect(images.length-1);
      imageWidthAndHeight(i);
      setState(() {});
      return 0;
    }
    return 1;
  }

  void imageSelect(int index){
    image = images[index];
    i = index;
    heightController.clear();
    widthController.clear();
  }

  Future<File> resizeImage(File file, int width, int height) async {
    var height1 = MediaQuery.of(context).size.height;
    var width1 = MediaQuery.of(context).size.width;
    showDialog(context: context, builder:(context){
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          height: height1,
          width: width1,
          color: Colors.transparent,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white,),
          ),
        ),
      );
    });
    try{
      final image = img.decodeImage(await file.readAsBytes());
      final resized = img.copyResize(image!, width: width, height: height);
      final resizedBytes = img.encodePng(resized);

      // Get writable temporary directory
      final tempDir = await getTemporaryDirectory();
      final random = Random();
      int randomNumber = random.nextInt(100000);
      final filePath = '${tempDir.path}/resize_image$randomNumber.png';
      final resizedFile = File(filePath);
      return resizedFile.writeAsBytes(resizedBytes);
    }catch(e){
      return image!;
    }
  }


  void imageWidthAndHeight(int index){
    Image image = Image.file(images[index]);
    ImageStream stream = image.image.resolve(ImageConfiguration());
    stream.addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        print('Width: ${info.image.width}');
        print('Height: ${info.image.height}');
        imageWidth = info.image.width;
        imageHeight = info.image.height;
        setState(() {});
      }),
    );
  }

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
                Text("Req#0${widget.index+1}", style: TextStyle(color: Colors.white, fontSize: 18),),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
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
              Container(
                height: height*0.1,
                width: width,
                decoration: BoxDecoration(
                  color: Color(0xff273894),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: height*0.07,
                    width: width*0.87,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Spacer(flex: 1,),
                        Text("Branding requirements:", style: TextStyle(fontWeight: FontWeight.bold, ),),
                        Text("${viewSurveyModelObject[widget.index].brandingElementName}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),),
                        Spacer(flex: 4,),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Container(
                      height: 1,
                      width: width*0.15,
                      color: Colors.grey,
                    ),
                    Text("Measurement and photo upload", style: TextStyle(fontWeight: FontWeight.bold),),
                    Container(
                      height: 1,
                      width: width*0.15,
                      color: Colors.grey,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                  child: Text("Backlit board"),
                ),
              ),
              SizedBox(
                height: height*0.45,
                width: width*0.92,
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          child: Container(
                            height: height*0.25,
                            width: width,
                            color: Colors.white,
                            child: ElevatedButton(
                              onPressed: () async{
                                await imagePick();
                              },
                              child: image != null ? Container(child: Image.file(image!,),key: key,): Center(
                                child: Column(
                                  children: [
                                    Image.asset("assets/Group.png"),
                                    Text("Add Photo", style: TextStyle(color: Color(0xff273894),),)
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Dimension"),
                            Spacer(),
                            IconButton(onPressed: () async{
                              if(heightController.text.isEmpty || widthController.text.isEmpty){
                                Fluttertoast.showToast(
                                  msg: "Height and width are required",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                return;
                              }
                              image = await resizeImage(image!, int.parse(widthController.text.trim().toString()), int.parse(heightController.text.trim().toString()));
                              images[i] = image!;
                              imageWidthAndHeight(i);
                              Navigator.pop(context);
                              setState(() {});
                            }, icon: Icon(Icons.save_as_rounded)),
                            Text("ft", style: TextStyle(color: Colors.grey),),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                      Container(
                        height: height*0.08,
                        width: width*0.8,
                        color: Color(0xffEFF1F6),
                        child: Row(
                          children: [
                            Container(
                              height: height*0.048,
                              width: width*0.25,
                              color: Colors.white,
                              child: Center(
                                child: TextField(
                                  showCursor: false,
                                  controller: widthController,
                                  enabled: imageWidth != null ? true : false,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    hintText: imageWidth != null ? imageWidth!.toString() : "         - -",
                                    hintStyle: TextStyle(color: Colors.grey)
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ),
                            Text(" W",style: TextStyle(color: Colors.grey, fontSize: 16),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("X",style: TextStyle(color: Colors.grey, fontSize: 12),),
                            ),
                            Container(
                              height: height*0.048,
                              width: width*0.25,
                              color: Colors.white,
                              child: TextField(
                                showCursor: false,
                                controller: heightController,
                                enabled: imageHeight != null ? true : false,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),
                                    ),
                                    hintText: imageHeight != null ? imageHeight!.toString() : "         - -",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Text(" H",style: TextStyle(color: Colors.grey, fontSize: 16),),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: height*0.1,
                  width: width,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Container(
                        width: width*0.75,
                        color: Colors.transparent,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.isNotEmpty ? images.length : 0,
                          itemBuilder: (context, int index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Container(
                                  height: height*0.05,
                                  width: width*0.2,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: i == index ? Colors.indigo : Colors.white, width: 2),
                                  ),
                                  child: Container(child: Image.file(images[index])),
                                ),
                                onTap: () {
                                  imageSelect(index);
                                  setState(() {});
                                  imageWidthAndHeight(index);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      IconButton(onPressed: () async{
                        await imagePick();
                      }, icon: Icon(Icons.add_photo_alternate_outlined, size: 38,),style: IconButton.styleFrom(backgroundColor: Colors.white),),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                child: SizedBox(
                  height: height*0.06,
                  width: width*0.9,
                  child: ElevatedButton(
                    onPressed: image != null ? () async{
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
                        return;
                      }
                      for(int i=0;i<images.length;i++){
                        await ImageUploadApi_ApiCall.imageUploadApi(context, images[i]);
                      }
                      heightWidth = {
                        "width": imageWidth.toString(),
                        "height": imageHeight.toString(),
                      };
                      String imagesUrls = "";
                      for(int i=0;i<imagesUrl.length;i++){
                        if(imagesUrl.length-1 == i){
                          imagesUrls = imagesUrls + imagesUrl[i];
                        }else{
                          imagesUrls = imagesUrls + imagesUrl[i] + ",";
                        }
                      }
                      print(imagesUrls);
                      await UploadSurvey_ApiCall.uploadSurveyApi(context, imagesUrls, heightWidth, viewSurveyModelObject[widget.index].id!);
                      Navigator.pop(context);
                      imagesUrl = [];
                      imagesUrl2 = [];
                      Fluttertoast.showToast(
                        msg: "Request Submit",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.lightBlueAccent,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Navigator.popUntil(context, (root) => root.isFirst);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                    } : null,
                    child: Text("Submit", style: TextStyle(fontSize: 18, color: image != null ? Colors.white: Colors.grey),),
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
          ),
        ),
      ),
    ),
    );
  }
}











