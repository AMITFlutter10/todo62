import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' ;
////////////////  CURD    //////
late Database database ;

creteDataBase()async{
  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
   //url/tasks.db
  print(databasesPath);
  var path = join(databasesPath,"tasks.db");
  // open the database
   database = await openDatabase(path, version: 1,

      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, task TEXT, time TEXT, date TEXT , status TEXT)').
        then((value) {
              print("table created");  // awl mra f awl run
        });
      } ,
        onOpen: (db){
        print("table open");
       // getData
        });
}

insertDatabase({
  String? task ,
  String? time,
  String? date,
})async{
   database.transaction((txn) async {
  await  txn.rawInsert('INSERT INTO tasks(task, time, date , status) VALUES($task, $time, $date ,"NotDone")').
  then((value) {
    print("task inserted $value Successfully ");
    //getDatabase ==> ui
  }
  ).catchError((error){
    print(error);
  });
  });
}

 updateDataBase({ String? task ,
   String? time,
   String? date,
   int? id,
 })async{
  await database.rawUpdate('UPDATE tasks SET task = ?, time = ? , date = ? ,WHERE id = ?',
      [task, time, date , id]).then((value) {
        print("$value is updated");
        //getDatabase
  }).catchError((error){
    print(error);
  });
 }

 updateStatus(String status , int id )async{
 await database.rawUpdate('UPDATE tasks SET status = ? ,WHERE id = ?',
 [status, id]).then((value) {
 print("status is updated");
 //getDatabase
 }).catchError((error){
 print(error);
 });}


  deleteDataBase({required int id}){
  database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
    print("$value is deleted ");
  }).catchError((error){
    print(error);
  });
  }

 List<Map> itemTasks =[];
 getDatabase(Database database)async{
   database.rawQuery('SELECT * FROM tasks').then((value) {
     for(Map<String, dynamic>  element in value){
       itemTasks.add(element);
     }
   }).catchError((error){
     print(error);
   });
 }





