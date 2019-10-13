import '../model/student.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class DatabaseHelper{
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String studentTable = "studentTable";
  final String columnId = "id";
  final String columnFirstName = "firstName";
  final String columnLastName = "lastName";
  final String columnContactNumber = "contactNumber";

  // Create a static database
  static Database _db;

  Future<Database> get db async {
    if(_db != null) {
      return _db;
    }

    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    // Use the join method to join the path to the name of the database which is going to be "studentRecords.db"
    String path = join(documentDirectory.path, "studentRecords.db");

    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $studentTable($columnId INTEGER PRIMARY KEY, $columnFirstName TEXT, $columnLastName TEXT, $columnContactNumber TEXT)"
    );
  }

  //////////////
  ///INSERTION//
  //////////////
  
  // Whenever you insert data into database it returns a integer value
  Future<int> saveStudent (Student student) async {
    var dbClient = await db;
    int result = await dbClient.insert("$studentTable", student.toMap());
    return result;
  }


  // Get all student Records
  Future<List>getStudentRecords() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $studentTable");
    return result.toList();
  }
  
  Future<Student> getStudentRecord(int id) async {
    var dbClient = await db;

    var result = await dbClient.rawQuery("SELECT * FROM $studentTable WHERE $columnId = $id");

    if (result.length == 0) return null;
    return new Student.fromMap(result.first);
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $studentTable"));
  }

  //////////////
  ////UPDATE////
  //////////////
  
  Future<int> updateRecords(Student student) async {
    var dbClient = await db;
    return await dbClient.update("$studentTable", student.toMap(), where: "$columnId = ?", whereArgs: [student.id]);
  }

  //////////////
  ////DELETE////
  //////////////
  
  Future<int> deleteRecord(int id) async {
    var dbClient = await db;
    return await dbClient.delete(studentTable, where: "$columnId = ?", whereArgs: [id]);
  }

  //////////////////////
  ////CLOSE DATABASE////
  //////////////////////
  
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}