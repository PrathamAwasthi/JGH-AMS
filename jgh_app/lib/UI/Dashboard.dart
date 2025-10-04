import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jgh_app/Api_Call/BankAccountList.dart';
import 'package:jgh_app/Api_Call/PaymentListApi.dart';
import 'package:jgh_app/Api_Call/RaiseTicketApi.dart';
import 'package:jgh_app/Api_Call/SurveyListApi.dart';
import 'package:jgh_app/Api_Call/dashboardApi.dart';
import 'package:jgh_app/Api_Call/installationListApi.dart';
import 'package:jgh_app/Api_Call/profileApi.dart';
import 'package:jgh_app/ScreenState/NavigationButton.dart';
import 'package:jgh_app/UI/HomePage.dart';
import 'package:jgh_app/UI/Installation.dart';
import 'package:jgh_app/UI/InternetNotWorking.dart';
import 'package:jgh_app/UI/Payment.dart';
import 'package:jgh_app/UI/Profile.dart';
import 'package:jgh_app/UI/SurveyPage.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../Model/Profile_Model.dart';
import 'RaiseTicket.dart';

class DashboardPage extends StatefulWidget{
  DashboardPage({super.key});
  State<StatefulWidget> createState(){
    return DashboardPageState();
  }
}

NavigationButton? gloebleProvider;

class DashboardPageState extends State<DashboardPage>{

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  bool check = false;
  Future<int> apiCall() async{
    bool result = await InternetConnection().hasInternetAccess;
    if(result){
      await Profile_ApiCall.profileOtp(context);
      await DashboardApi_ApiCall.dashboardApi(context);
      await SurveyListApi_ApiCall.surveyListApi(context);
      await InstallationListApi_ApiCall.installationListApi(context, "1");
      await PaymentListApi_ApiCall.paymentListApi(context);
      await RaiseTicket_ApiCall.RaiseTicketProfile(context);
      check = true;
      setState(() {});
    } else{
      Fluttertoast.showToast(
          msg: "Please Check Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => InternetNotWorking()));
    }
    return 0;
  }

  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if(check){
      return ChangeNotifierProvider<NavigationButton>(
        create: (context) => NavigationButton(),
        child: Consumer<NavigationButton>(builder: (context, provider,child){
          gloebleProvider = provider;
          return WillPopScope(
            child: SafeArea(
              child: Scaffold(
            key: scaffoldKey,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(height*0.085),
                child: Container(
                  color: Color(0xff273894),
                  child: Row(
                    children: [
                    IndexedStack(
                      index: provider.index-1,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: InkWell(
                            child: Row(
                              children: [
                                InkWell(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                    child: Image.asset("assets/Header Left.png"),
                                  ),
                                  onTap: (){
                                    scaffoldKey.currentState?.openDrawer();
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                                  child: Image.asset("assets/Frame 1686551700.png"),
                                ),
                                provider.index != 5 ? Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.35,0,0,0),
                                  child: IconButton(
                                      onPressed: () async{
                                      }, icon: Icon(Icons.notifications_none, color: Colors.white, size: 32,)),
                                ) : Text(""),
                                provider.index != 5 ? Padding(
                                  padding: const EdgeInsets.fromLTRB(0.1,0,0,0),
                                  child: IconButton(
                                      onPressed: () async{
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => RaiseTicket()));
                                      }, icon: Icon(Icons.support_agent, color: Colors.white, size: 32,)),
                                ) : Text(""),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Container(
height: height*0.08,
width: width*0.8,
color: Colors.transparent,
child: Row(
children: [
IconButton(onPressed: (){ provider.homeButton();}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
Text("Retailer branding request", style: TextStyle(color: Colors.white, fontSize: 18),),
],
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.center,
),
),
                        Container(
height: height*0.08,
width: width*0.8,
color: Colors.transparent,
child: Row(
children: [
IconButton(onPressed: (){ provider.homeButton();}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
Text("Installation Status", style: TextStyle(color: Colors.white, fontSize: 18),),
],
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.center,
),
),
                        Container(
height: height*0.08,
width: width*0.8,
color: Colors.transparent,
child: Row(
children: [
IconButton(onPressed: (){ provider.homeButton();}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
Text("Payment Status", style: TextStyle(color: Colors.white, fontSize: 18),),
],
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.center,
),
),
                        Container(
height: height*0.08,
width: width*0.8,
color: Colors.transparent,
child: Row(
children: [
IconButton(onPressed: (){ provider.homeButton();}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
Text("My Profile", style: TextStyle(color: Colors.white, fontSize: 18),),
],
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.center,
),
),
                      ],
                    ),
                    ],
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
              child: IndexedStack(
                index: provider.index-1,
                children: [
                  HomePage(),
                  SurveyPage(),
                  InstallationPage(),
                  Payment(),
                  Profile(),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: height*0.105,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width*0.05),
                  topRight: Radius.circular(width*0.05),
                ),
              ),
              child: Row(
                children: [
                  provider.index == 1 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (5).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.homeButton();},
                  ) :
                  InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (5).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.homeButton();},
                  ),
                  provider.index == 2 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (1).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.survey();},
                  ) :
                  InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (1).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.survey();},
                  ),
                  provider.index == 3 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (2).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: () async{status = "1";await InstallationListApi_ApiCall.installationListApi(context, "1");provider.installation();},
                  ) :
                  InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (2).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: () async{status = "1";await InstallationListApi_ApiCall.installationListApi(context, "1");provider.installation();},
                  ),
                  provider.index == 4 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (3).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.payment();},
                  ) :
                  InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (3).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.payment();},
                  ),
                  provider.index == 5 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (4).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.profile();},
                  ) :
                  InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (4).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.profile();},
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
            drawer: Drawer(
                  backgroundColor: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: height*0.17,
                        color: Colors.transparent,
                        child: InkWell(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(width*0.02,height*0.02,0,0),
                                child: Container(
                                    height: height*0.07,
                                    width: height*0.07,
                                    decoration: BoxDecoration(
                                      color: Colors.grey, shape: BoxShape.circle,
                                      border: Border.all(color: Colors.indigo),
                                    ),
                                    child: ClipOval(child: Image.network("http://ams.jghmagic.com/"+ProfileData.profileImage!, height: height*0.05, width: height*0.05, fit: BoxFit.cover,))),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(width*0.04,height*0.02,0,0),
                                child: Text("Hi ${ProfileData.name}", style: TextStyle(color: Colors.black, fontSize: 16),),
                              ),
                            ],
                          ),
                          onTap: (){
                            Navigator.pop(context);
                            gloebleProvider!.profile();
                          },
                        ),
                      ),
                      SizedBox(
                        height: height*0.08,
                        child: ElevatedButton(
                            onPressed: () async{
                              Navigator.pop(context);
                              await BankAccountList_ApiCall.bankAccountListApi(context);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.account_balance, size: 24, color: Color(0xff273894),),
                                Spacer(flex: 1,),
                                Text("Banks Account", style: TextStyle(fontSize: 16, color: Colors.black),),
                                Spacer(flex: 9,),
                                Icon(Icons.arrow_forward_ios, color: Colors.black,),
                              ],
                            ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(),
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onWillPop: () async {
              if(provider.index == 1){
                showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        content: Container(
                          height: height*0.2,
                          width: width*.5,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Text("Are you sure you want to leave?", style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold),),
                              ElevatedButton(
                                onPressed: (){
                                  SystemNavigator.pop();
                                },
                                child: Text("Exit", style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  backgroundColor: Colors.indigo
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                        ),
                        backgroundColor: Colors.white,
                      );
                    },
                );
              }
              provider.homeButton();
              print("Back button pressed!");
              return false; // false करने से route pop नहीं होगा
            },
          );
        }),
      );
    } else{
      return ChangeNotifierProvider<NavigationButton>(
        create: (context) => NavigationButton(),
        child: Consumer<NavigationButton>(builder: (context, provider,child){
          return WillPopScope(
            child: SafeArea(child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(height*0.085),
                child: Container(
                  color: Color(0xff273894),
                  child: Row(
                    children: [
                      IndexedStack(
                        index: provider.index-1,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: InkWell(
                              child: Row(
                                children: [
                                  InkWell(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(width*0.02,0,0,0),
                                      child: Image.asset("assets/Header Left.png"),
                                    ),
                                    onTap: (){},
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                                    child: Image.asset("assets/Frame 1686551700.png"),
                                  ),
                                  provider.index != 5 ? Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.35,0,0,0),
                                    child: IconButton(
                                        onPressed: () async{
                                        }, icon: Icon(Icons.notifications_none, color: Colors.white, size: 32,)),
                                  ) : Text(""),
                                  provider.index != 5 ? Padding(
                                    padding: const EdgeInsets.fromLTRB(0.1,0,0,0),
                                    child: IconButton(
                                        onPressed: () async{
                                        }, icon: Icon(Icons.support_agent, color: Colors.white, size: 32,)),
                                  ) : Text(""),
                                ],
                              ),
                              onTap: (){},
                            ),
                          ),
                          Container(
                            height: height*0.08,
                            width: width*0.8,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){ provider.homeButton();}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                                Text("Retailer branding request", style: TextStyle(color: Colors.white, fontSize: 18),),
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                          Container(
                            height: height*0.08,
                            width: width*0.8,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){ provider.homeButton();}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                                Text("Installation Status", style: TextStyle(color: Colors.white, fontSize: 18),),
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                          Container(
                            height: height*0.08,
                            width: width*0.8,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){ provider.homeButton();}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                                Text("Payment Status", style: TextStyle(color: Colors.white, fontSize: 18),),
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                          Container(
                            height: height*0.08,
                            width: width*0.8,
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){ provider.homeButton();}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
                                Text("My Profile", style: TextStyle(color: Colors.white, fontSize: 18),),
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                        ],
                      ),
                    ],
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
              child: IndexedStack(
                index: provider.index-1,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                        child: Row(
                          children: [
                            Shimmer(
                              color: Colors.indigo.shade200,
                              child: SizedBox(
                                height: height*0.15,
                                width: width*0.45,
                                child: Card(
                                  elevation: 10,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                            ),
                            Shimmer(
                              color: Colors.indigo.shade200,
                              child: SizedBox(
                                height: height*0.15,
                                width: width*0.45,

                                child: Card(
                                  elevation: 10,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                        child: Row(
                          children: [
                            Shimmer(
                              color: Colors.indigo.shade200,
                              child: SizedBox(
                                height: height*0.15,
                                width: width*0.45,
                                child: Card(
                                  elevation: 10,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                            ),
                            Shimmer(
                              color: Colors.indigo.shade200,
                              child: SizedBox(
                                height: height*0.15,
                                width: width*0.45,
                                child: Card(
                                  elevation: 10,
                                  color: Colors.grey.shade100,
                                ),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: height*0.07,
                        width: width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Shimmer(color: Colors.indigo.shade200,child: Text("Total Requests:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                              Spacer(),
                              IconButton(
                                icon: Image.asset("assets/Vector (2).png"),
                                onPressed: (){},
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                      ),
                      Container(
                          height: height*0.66,
                          width: width,
                          color: Colors.transparent,
                          child: RefreshIndicator(child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, int index){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: height*0.4,
                                  width: width,
                                  child: Shimmer(
                                    color: Colors.indigo.shade200,
                                    child: Card(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ), onRefresh: () async{})
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: height*0.07,
                        width: width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Shimmer(color: Colors.indigo.shade200,child: Text("All:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
                              Spacer(),
                              IconButton(
                                icon: Image.asset("assets/Vector (2).png"),
                                onPressed: (){},
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                      ),
                      Container(
                          height: height*0.66,
                          width: width,
                          color: Colors.transparent,
                          child: RefreshIndicator(child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, int index){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: height*0.4,
                                  width: width,
                                  child: Shimmer(
                                    color: Colors.indigo.shade200,
                                    child: Card(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ), onRefresh: () async{})
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          height: height*0.731,
                          width: width,
                          color: Colors.transparent,
                          child: RefreshIndicator(child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, int index){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: height*0.4,
                                  width: width,
                                  child: Shimmer(
                                    color: Colors.indigo.shade200,
                                    child: Card(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ), onRefresh: () async{})
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          Shimmer(
                            child: Container(
                              height: height*0.2,
                              width: width,
                              decoration: BoxDecoration(
                                color: Color(0xff273894),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(40),
                                  bottomLeft: Radius.circular(40),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
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
                                            child: Container(
                                              height: height*0.12,
                                              width: height*0.12,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey.shade100,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(width*0.04,0,0,0),
                                    child: Column(
                                      children: [
                                        Shimmer(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              height: height*0.015,
                                              width: width*0.5,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Shimmer(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Container(
                                              height: height*0.015,
                                              width: width*0.5,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.05,0,0),
                              child: Row(
                                children: [
                                  Shimmer(
                                    color: Colors.indigo.shade200,
                                    child: Container(
                                      height: height*0.07,
                                      width: width*0.45,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  Shimmer(
                                    color: Colors.indigo.shade200,
                                    child: Container(
                                      height: height*0.07,
                                      width: width*0.45,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                              child: Shimmer(
                                color: Colors.indigo.shade200,
                                child: Container(
                                  height: height*0.08,
                                  width: width*0.95,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                              child: Shimmer(
                                color: Colors.indigo.shade200,
                                child: Container(
                                  height: height*0.08,
                                  width: width*0.95,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                              child: Shimmer(
                                color: Colors.indigo.shade200,
                                child: Container(
                                  height: height*0.12,
                                  width: width*0.95,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                              child: Shimmer(
                                color: Colors.indigo.shade200,
                                child: Container(
                                  height: height*0.08,
                                  width: width*0.95,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                              child: Shimmer(
                                color: Colors.indigo.shade200,
                                child: Container(
                                  height: height*0.12,
                                  width: width*0.95,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                              child: Shimmer(
                                color: Colors.indigo.shade200,
                                child: Container(
                                  height: height*0.08,
                                  width: width*0.95,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: height*0.105,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width*0.05),
                  topRight: Radius.circular(width*0.05),
                ),
              ),
              child: Row(
                children: [
                  provider.index == 1 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (5).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.homeButton();},
                  ) : InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (5).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.homeButton();},
                  ),
                  provider.index == 2 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (1).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.survey();},
                  ) : InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (1).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.survey();},
                  ),
                  provider.index == 3 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (2).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.installation();},
                  ) : InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (2).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.installation();},
                  ),
                  provider.index == 4 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (3).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.payment();},
                  ) : InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (3).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.payment();},
                  ),
                  provider.index == 5 ? InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Color(0xff273894),
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (4).png", color: Color(0xff273894), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.profile();},
                  ) : InkWell(
                    child: Column(
                      children: [
                        Container(
                          height: 5,
                          width: width*0.15,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width)
                          ),
                        ),
                        Image.asset("assets/Item (4).png", color: Color(0xffCFD6DC), scale: 0.99,),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    onTap: (){provider.profile();},
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),),
            onWillPop: () async {
              if(provider.index == 1){
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      content: Container(
                        height: height*0.2,
                        width: width*.5,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Text("Are you sure you want to leave?", style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold),),
                            ElevatedButton(
                              onPressed: (){
                                SystemNavigator.pop();
                              },
                              child: Text("Exit", style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  backgroundColor: Colors.indigo
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                      backgroundColor: Colors.white,
                    );
                  },
                );
              }
              provider.homeButton();
              print("Back button pressed!");
              return false; // false करने से route pop नहीं होगा
            },
          );
        }),
      );
    }
  }
}

