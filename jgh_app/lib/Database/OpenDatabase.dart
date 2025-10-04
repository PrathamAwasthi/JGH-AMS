import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jgh_app/Util/AppConst.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseOpen {
  static late final Database database;
  static final String tableName = "connection_info";
  static final String connection_idColumnName = "connection_id";
  static final String auth_codeColumnName = "auth_code";
  static List<Map<String, dynamic>> mainData = [];

  static Future<int> openDB(BuildContext context) async{
    try{
      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path,"JGHAMS.db");
      database = await openDatabase(path, onCreate: (db, version){
        db.execute("CREATE TABLE $tableName(id INTEGER PRIMARY KEY, connection_id TEXT, auth_code TEXT);");
      }, version: 1);
    }catch(e){
      return 1;
    }
    return 0;
  }

  static Future<int> insertDate(BuildContext context, String connection_id, String authCode) async{
    try{
      await database.insert(
        'connection_info',
        {
          'connection_id': connection_id,
          'auth_code': authCode,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      accessDB(context);
    }catch(e){
      return 1;
    }
    return 0;
  }

  static Future<int> accessDB(BuildContext context) async{
    try{
      var res = await database.query(tableName);
      mainData = [];
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(res);
      print(res);
      mainData = data;
      if(mainData.isNotEmpty){
        AppConst.connectionId = mainData[0]["connection_id"];
        AppConst.authCode = mainData[0]["auth_code"];
      }
      print(mainData.isEmpty);
    }catch(e){
      return 1;
    }
    return 0;
  }

}
