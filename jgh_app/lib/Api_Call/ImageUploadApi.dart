import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jgh_app/Util/AppConst.dart';

List<String> imagesUrl = [];
List<String> imagesUrl2 = [];
class ImageUploadApi_ApiCall {
  static Future<int> imageUploadApi(BuildContext context, File imageFile) async{
    try{
      var url = Uri.parse(AppConst.uploadImageUrl);
      var headers = {
        'Content-Type': 'application/json',
      };
      final bytes = await imageFile.readAsBytes();
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
          imagesUrl.add(data["upload_image"]["url"]);
          imagesUrl2.add(data["upload_image"]["url"]);
          print("ppppppppppppppppppppppppppppppppppppPP");
          print("ppppppppppppppppppppppppppppppppppppPP");
          return 0;
        }
      }
    }catch(e){
      return 1;
    }
    return 0;
  }
}








