import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jgh_app/Api_Call/ticketStoreApi.dart';
import 'package:jgh_app/Model/Profile_Model.dart';


class CreateTicket extends StatefulWidget{
  State<StatefulWidget> createState(){
    return CreateTicketState();
  }
}

class CreateTicketState extends State<CreateTicket>{
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  List<File> images = [];
  String selectedValue = 'Low';
  List<String> options = ['Low', 'Medium', 'High', 'Critical'];
  ScrollController scrollController = ScrollController();


  Future<int> imagePick() async{
    final XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(file != null){
      images.add(File(file.path));
    }
    setState(() {});
    return 0;
  }

  Widget build(BuildContext){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height*0.085,
                      width: width,
                      decoration: BoxDecoration(
                        color: Color(0xff273894),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white,),
                          ),
                          Text("Create ticket", style: TextStyle(color: Colors.white, fontSize: 18),),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,height*0.04,0,0),
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
                              Row(
                                children: [
                                  Text("Title", style: TextStyle(color: Color(0xff273894)),),
                                  Text("*", style: TextStyle(color: Colors.red),),
                                ],
                              ),
                              TextField(
                                controller: title,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: "Enter Ticket Title",
                                ),
                                onChanged: (value){
                                  setState(() {});
                                },
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,height*0.02,0,0),
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
                              Row(
                                children: [
                                  Text("description", style: TextStyle(color: Color(0xff273894)),),
                                  Text("*", style: TextStyle(color: Colors.red),),
                                ],
                              ),
                              TextField(
                                controller: description,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  hintText: "Enter Description",
                                ),
                                maxLines: 4,
                                onChanged: (value){
                                  setState(() {});
                                },
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Priority", style: TextStyle(color: Color(0xff273894)),),
                            ],
                          ),
                          Container(
                            height: height*0.07,
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)
                            ),
                            child: Center(
                              child: DropdownButton<String>(
                                value: selectedValue,
                                style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
                                icon: Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.6,0,0,0),
                                  child: Icon(Icons.arrow_drop_down, size: 28,),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                    setState(() {});
                                  });
                                },
                                items: options.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                      child: images.isNotEmpty ? Column(
                        children: [
                          Row(
                            children: [

                              Text("  Attach File", style: TextStyle(color: Color(0xff273894)),),
                            ],
                          ),
                          Container(
                            height: height*0.2,
                            width: width*0.95,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration( border: Border.all(color: Colors.black), color: Colors.transparent,),
                                  height: height*2,
                                  width: width*0.5,
                                  child: Scrollbar(
                                    controller: scrollController,
                                    thumbVisibility: true,
                                    child: ListView.builder(
                                    controller: scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: images.length,
                                    itemBuilder: (context, int index){
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Image.file(images[index], width: width*0.5,),
                                        ),
                                      );
                                    },
                                  ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: height*0.24,
                                    width: width*0.4,
                                    color: Colors.grey.shade300,
                                    child: InkWell(
                                      child: Column(
                                        children: [
                                          Icon(Icons.attach_file, size: 32,),
                                          Text("Add more")
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                      ),
                                      onTap: () async{
                                        await imagePick();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                        ],
                      ) : Column(
                        children: [
                          Row(
                            children: [
                              Text("   Attach File", style: TextStyle(color: Color(0xff273894)),),
                            ],
                          ),
                          Container(
                            height: height*0.07,
                            width: width*0.95,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Text("    Upload File/Image ", style: TextStyle(color: Colors.grey.shade700),),
                                  IconButton(
                                    onPressed: () async{
                                      await imagePick();
                                    },
                                    icon: Icon(Icons.attach_file),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: height*0.01,
                left: 16,
                right: 16,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0,images.isEmpty ? height*0.25 : height*0.08,0,0),
                  child: SizedBox(
                    height: height*0.06,
                    width: width*0.95,
                    child: ElevatedButton(
                      onPressed: title.text.isNotEmpty && description.text.isNotEmpty ? () async{
                        int priority = 0;
                        if(selectedValue == "Low"){
                          priority = 0;
                        }else if(selectedValue == "Medium"){
                          priority = 1;
                        }else if(selectedValue == "High"){
                          priority = 2;
                        }else if(selectedValue == "Critical"){
                          priority = 3;
                        }
                        await TicketStore_ApiCall.TicketStoreApi(
                          context,
                          userID: ProfileData.id!,
                          title: title.text.toString(),
                          description: description.text.toString(),
                          images: images,
                          priority: priority.toString(),
                        );
                      } :(){},
                      child: Text("Submit", style: TextStyle(color: title.text.isNotEmpty && description.text.isNotEmpty ? Colors.black : Colors.white),),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: title.text.isNotEmpty && description.text.isNotEmpty ? Color(0xffFBB82A) : Colors.grey,
                      ),
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



