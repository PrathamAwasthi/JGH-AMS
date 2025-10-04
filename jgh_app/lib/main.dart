import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jgh_app/Database/OpenDatabase.dart';
import 'package:jgh_app/UI/Dashboard.dart';
import 'package:jgh_app/UI/LoginAccount.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigate();
  }


  void navigate() async{
    await DatabaseOpen.openDB(context);
    await DatabaseOpen.accessDB(context);
    Timer(Duration(seconds: 2), () {
      if(DatabaseOpen.mainData.isEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardPage()));
      }
    });
  }

  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue.shade400,
            Colors.blueAccent.shade700,
          ],
            begin: Alignment.topCenter,
          ),
        ),
        height: height,
        width: width,
        child: Column(
          children: [
            Image.asset("assets/Frame 1686551700.png"),
            Image.asset("assets/7650 1.png"),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        ),
      ),
    );
  }
}

