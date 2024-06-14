import 'package:sqflite/sqflite.dart';

////////////////  CURD    //////

creteDataBase()async{
  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  print(databasesPath);
}