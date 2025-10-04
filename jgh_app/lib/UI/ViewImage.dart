import 'package:flutter/material.dart';



class ViewImage extends StatefulWidget{
  String image;
  ViewImage({super.key, required this.image});
  State<StatefulWidget> createState(){
    return ViewImageState();
  }
}

class ViewImageState extends State<ViewImage>{
  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.black,
        child: Center(
          child: InteractiveViewer(
            panEnabled: true, // Allow dragging
            scaleEnabled: true, // Allow zooming
            minScale: 0.5,
            maxScale: 4,
            child: Image.network(widget.image),
          ),
        ),
      ),
    );
  }
}