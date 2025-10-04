import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jgh_app/Api_Call/SurveyListApi.dart';
import 'package:jgh_app/Api_Call/ViewSurvey_Api.dart';
import 'package:jgh_app/Model/SurveyList_Model.dart';
import 'package:url_launcher/url_launcher.dart';

class SurveyPage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return SurveyPageState();
  }
}

Future<void> openMap(double latitude, double longitude) async {
  // Option 1: Using geo: URI scheme (Recommended for native map app)
  // This is generally preferred as it tries to open the native map application
  final Uri geoUrl = Uri.parse('geo:$latitude,$longitude');

  // Option 2: Using Google Maps web URL (Falls back to browser if no map app)
  // This will open Google Maps in a web browser, or if the device has the app,
  // it might redirect to the app.
  final Uri googleMapsWebUrl = Uri.parse('https://maps.google.com/?q=$latitude,$longitude');

  // Try to launch the native map app first
  if (await canLaunchUrl(geoUrl)) {
    await launchUrl(geoUrl, mode: LaunchMode.externalApplication);
  }
  // If native map app cannot be launched, try to open in a web browser
  else if (await canLaunchUrl(googleMapsWebUrl)) {
    await launchUrl(googleMapsWebUrl, mode: LaunchMode.externalApplication);
  }
  else {
    throw 'Could not open the map. Please ensure a map application is installed.';
  }
}



class SurveyPageState extends State<SurveyPage>{

  String address = "";

  void getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks[0];
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      print("Address: $address");

    } catch (e) {
      print("Error fetching address: $e");
    }
  }

  Widget build(BuildContext context){
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: height*0.07,
            width: width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text("Total Requests:${surveyListModelObjects.length}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                  Spacer(),
                ],
                  crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
          Expanded(child: Container(
              width: width,
              color: Colors.transparent,
              child: RefreshIndicator(child: ListView.builder(
                itemCount: surveyListModelObjects.length,
                itemBuilder: (context, int index){
                  getAddressFromLatLng(double.parse(surveyListModelObjects[index].latitude!), double.parse(surveyListModelObjects[index].longitude!));
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: height*0.4,
                      width: width,
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Container(
                                    height: height*0.02,
                                    width: width*0.15,
                                    decoration: BoxDecoration(
                                      color: Color(0xffEBEEFF),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(child: Text("Req#0${index+1}", style: TextStyle(color: Color(0xff273894)),)),
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.circle,size: 10, color: Color(0xffFEB211),),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,0,20,0),
                                  child: Text(" ${surveyListModelObjects[index].statusLabel}", style: TextStyle(color: Color(0xffFEB211)),),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.05,0,0,0),
                                  child: Container(
                                    color: Colors.transparent,
                                    width: width*0.52,
                                    child: Column(
                                      children: [
                                        Text("${surveyListModelObjects[index].ownerName}", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,),
                                        Text("${surveyListModelObjects[index].createdAt}", style: TextStyle(color: Colors.black, fontSize: 14,), overflow: TextOverflow.ellipsis,),
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,0,width*0.02,0),
                                  child: InkWell(
                                    child: Image.asset("assets/Frame 1984079673.png",scale: 0.8,),
                                    onTap: () async{
                                      await openMap(double.parse(surveyListModelObjects[index].latitude!), double.parse(surveyListModelObjects[index].longitude!));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,0,width*0.02,0),
                                  child: InkWell(
                                    child: Image.asset("assets/Frame 1984079676.png",scale: 0.8,),
                                    onTap: () async{
                                      final String phone = "91${surveyListModelObjects[index].mobileNumber}"; // phone number with country code
                                      final String message = "Hello";
                                      final url = Uri.parse("https://wa.me/$phone?text=${Uri.encodeComponent(message)}");
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url, mode: LaunchMode.externalApplication);
                                      } else {
                                        throw "Could not launch $url";
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,0,width*0.05,0),
                                  child: InkWell(
                                    child: Image.asset("assets/Frame 1984079674.png", scale: 0.8,),
                                    onTap: () async{
                                      final Uri callUri = Uri.parse("tel:${surveyListModelObjects[index].mobileNumber}");
                                      if (await canLaunchUrl(callUri)) {
                                        await launchUrl(callUri);
                                      } else {
                                        throw 'Could not launch dialer';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.03,height*0.01,0,0),
                                  child: Image.asset("assets/iconoir_shop.png",scale: 0.8,),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.01,height*0.01,0,0),
                                  child: Text("${surveyListModelObjects[index].shopName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(width*0.03,height*0.01,0,0),
                                          child: Icon(Icons.location_on_outlined, color: Color(0xffBEBEBE),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(width*0.01,height*0.01,0,0),
                                          child: Container(
                                            height: height*0.05,
                                            width: width*0.5,
                                            color: Colors.white,
                                            child: Align(alignment: Alignment.centerLeft,child: Text("${address}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2,)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(width*0.03,height*0.01,0,0),
                                          child: Icon(Icons.phone, color: Color(0xffBEBEBE),),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(width*0.01,height*0.01,0,0),
                                          child: Container(
                                            height: height*0.05,
                                            width: width*0.5,
                                            color: Colors.white,
                                            child: Align(alignment: Alignment.centerLeft,child: Text("+91 ${surveyListModelObjects[index].mobileNumber}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: height*0.09,
                                  width: width*0.3,
                                  color: Colors.transparent,
                                  child: Image.network("https://beta.jghmagic.com/images/geo_tagimage_images/geo_tagimage_mechanic_46602.jpeg"),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,height*0.01,0,0),
                              child: SizedBox(
                                height: height*0.05,
                                width: width*0.8,
                                child: ElevatedButton(
                                  onPressed: () async{
                                    await ViewSurvey_ApiCall.ViewSurveyApi(context, owner_id: surveyListModelObjects[index].userId!);
                                  },
                                  child: Text("View Survey", style: TextStyle(fontSize: 18, color: Colors.white),),
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
                  );
                },
              ), onRefresh: () async{
                await SurveyListApi_ApiCall.surveyListApi(context);
                setState(() {});
              })
          ),),
        ],
      ),
    );
  }
}




