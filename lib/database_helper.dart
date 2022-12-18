import 'ground.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{

  static Database? _database;

  String groundTable='ground_table';
  String colId='id';
  String colImg='imgPath';
  String colName='name';
  String colPitch='pitch';
  String colLoc='loc';

  String available1Table='available1_table';
  String colDate='date';
  String colAvailable1='available1';

  String available2Table='available2_table';
  String colOvers='overs';
  String colTime='time';
  String colTeam1='team1';
  String colTeam2='team2';
  String colAvailable2='available2';
  String colCost='cost';
  String colBallProvided='ballProvided';
  String colUmpireProvided='umpireProvided';
  String colBallDetail='ballDetail';

  DatabaseHelper._createInstance();
static DatabaseHelper _databaseHelper=DatabaseHelper._createInstance();
factory DatabaseHelper(){
  if(_databaseHelper==null)
  {
    _databaseHelper=DatabaseHelper._createInstance();
  }
  return _databaseHelper;
}


Future<Database?> get database async{
  if(_database==null)
  {
    _database=await initializeDatabase();
  }
  return _database;
}



Future<Database> initializeDatabase() async{
  Directory directory=await getApplicationDocumentsDirectory();
  String path=directory.path+'ground.db';
  var groundDatabase=await openDatabase(
    path,version: 1,onCreate: _createDb
  );
  return groundDatabase;

}

void _createDb(Database db,int newVersion) async{
  await db.execute(
    'CREATE TABLE $groundTable($colId INTEGER PRIMARY KEY,$colImg TEXT,$colName TEXT,$colPitch INTEGER,$colLoc TEXT)'
  );
  await db.execute(
    'CREATE TABLE $available1Table($colId INTEGER,$colDate TEXT,$colAvailable1 TEXT)'
  );
  await db.execute(
    'CREATE TABLE $available2Table($colId INTEGER,$colDate TEXT,$colOvers INTEGER,$colTime TEXT,$colTeam1 TEXT,$colTeam2 TEXT,$colAvailable2 TEXT,$colCost INTEGER,$colBallProvided TEXT,$colUmpireProvided TEXT,$colBallDetail TEXT)'
  );
}

Future<List<Map<String,dynamic>>> getGroundMapList() async{
  Database? db=await this.database;
  var result=await db!.query(groundTable,orderBy: '$colName ASC');
  return result;
}
Future<List<Map<String,dynamic>>> getAvailable1MapList() async{
  Database? db=await this.database;
  var result=await db!.query(available1Table);
  return result;
}
Future<List<Map<String,dynamic>>> getAvailable2MapList() async{
  Database? db=await this.database;
  var result=await db!.query(available2Table);
  return result;
}

Future<int> insertGround(Ground g) async{
  Database? db=await this.database;
  var result=await db!.insert(groundTable, g.toMapGround());
  return result;
}
Future<int> insertAvailable1(Ground g) async{
  Database? db=await this.database;
  var result=await db!.insert(available1Table, g.toMapAvailable1());
  return result;
}
Future<int> insertAvailable2(Ground g) async{
  Database? db=await this.database;
  var result=await db!.insert(available2Table, g.toMapAvailable2());
  return result;
}

Future<int> updateGround(Ground g) async {
  Database? db=await this.database;
  var result=await db!.update(groundTable, g.toMapGround(), where: '$colId=?',whereArgs: [g.id]);
  return result;
  }
Future<int> updateAvailable1(Ground g) async {
  Database? db=await this.database;
  var result=await db!.update(available1Table, g.toMapAvailable1(), where: '$colId=?',whereArgs: [g.id]);
  return result;
  }
Future<int> updateAvailable2(Ground g) async {
  Database? db=await this.database;
  var result=await db!.update(available2Table, g.toMapAvailable2(), where: '$colId=?',whereArgs: [g.id]);
  return result;
  }

Future<int> deleteGround(int id) async {
  Database? db=await this.database;
  var result=await db!.rawDelete('DELETE FROM $groundTable');
  return result;
}
Future<int> deleteAvailable1(int id) async {
  Database? db=await this.database;
  var result=await db!.rawDelete('DELETE FROM $available1Table WHERE $colId=$id');
  return result;
}
Future<int> deleteAvailable2(int id) async {
  Database? db=await this.database;
  var result=await db!.rawDelete('DELETE FROM $available2Table WHERE $colId=$id');
  return result;
}

Future<int?> getCount() async{
  Database? db=await this.database;
  List<Map<String,dynamic>> x=await db!.rawQuery('SELECT COUNT (*) FROM $groundTable');
  int? result=Sqflite.firstIntValue(x);
  return result;
}

Future<List<Ground>> getGroundList() async{
var groundMapList=await getGroundMapList();
int count=groundMapList.length;

List<Ground> groundList=<Ground>[];

for (var i = 0; i < count; i++) {
  groundList.add(Ground.fromMapObjectGround(groundMapList[i]));
}
return groundList;
}

Future<List<Ground>> getAvailableList() async{
var availableMapList=await getAvailable2MapList();
int count=availableMapList.length;

List<Ground> groundList=<Ground>[];

for (var i = 0; i < count; i++) {
  groundList.add(Ground.fromMapObjectGround(availableMapList[i]));
}
return groundList;
}
}