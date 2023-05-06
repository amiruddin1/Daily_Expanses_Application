import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:myexpanses/TBLTransaction.dart';

class DatabaseHelper{

  static final dbName = "DBExpanses.db";
  static final table = "TBLTransaction";
  static final version = 1;

  static final Field1 = "TransactionID_PK";
  static final Field2 = "TransactionTitle";
  static final Field3 = "TransactionDescription";
  static final Field4 = "TransactionAmount";
  static final Field5 = "TransactionDateTime";
  static final Field6 = "TransactionMode";


  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'my_database.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }
  Future _onCreate(var db,int version) async{
      await db.execute(
        '''
        CREATE TABLE $table($Field1 INTEGER PRIMARY KEY AUTOINCREMENT,$Field2 TEXT, $Field3 Text, $Field4 INTEGER,$Field5 DATETIME, $Field6 Text)
        '''
      );
  }
  Future<int> insertData(MyTransaction transaction) async{
    final now = DateTime.now();
    final Database db = await database;
    int result = await db.rawInsert("INSERT INTO $table ($Field2, $Field3, $Field4, $Field5, $Field6) values ('"+transaction.TransactionTitle+"','"+transaction.TransactionDescription+"','"+transaction.TransactionAmount.toString()+"','"+DateTime.now().toString()+"','"+transaction.TransactionMode+"')");
    
    return result;
  }

  Future<List<MyTransaction>> getCashTransaction() async{
    final Database db = await database;
    final c = await db.rawQuery("Select * from $table where $Field6 = 'Cash'");
    MyTransaction tr = MyTransaction(TransactionID_PK: 0,TransactionTitle: "",TransactionDescription: "",TransactionAmount: 0,TransactionMode: "",TransactionDateTime: "");
    List<MyTransaction> list = await tr.mapToList(c);
    return Future.value(list);
  }

  Future<List<MyTransaction>> getOnlineTransaction() async{
    final Database db = await database;
    final c = await db.rawQuery("Select * from $table where $Field6 = 'Bank'");
    MyTransaction tr = MyTransaction(TransactionID_PK: 0,TransactionTitle: "",TransactionDescription: "",TransactionAmount: 0,TransactionMode: "",TransactionDateTime: "");
    List<MyTransaction> list = await tr.mapToList(c);
    return Future.value(list);
  }

  Future<List<MyTransaction>> getSpecificDateData(DateTime date) async{
    final Database db = await database;
    MyTransaction tr = MyTransaction(TransactionID_PK: 0,TransactionTitle: "",TransactionDescription: "",TransactionAmount: 0,TransactionMode: "",TransactionDateTime: "");
    final formattedDate = date.toString().substring(0, 10);

    final records = await db.query(
      table,
      where: 'date(TransactionDateTime) = ?',
      whereArgs: [formattedDate],
    );
    List<MyTransaction> list = await tr.mapToList(records);
    return list;
  }

  Future<int> getTotalExpanse() async{
    final Database db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery('SELECT SUM($Field4) FROM $table');
    final sum = results[0]['SUM($Field4)'];
    return sum;
  }

  Future<int?> getTodayExpanse() async{
    final Database db = await database;
    final formattedDate = DateTime.now().toString().substring(0, 10);

    final records = await db.query(
      table,
      columns: ['SUM($Field4)'],
      where: 'date(TransactionDateTime) = ?',
      whereArgs: [formattedDate],
    );
    var sum = Sqflite.firstIntValue(records);
    return sum;
  }

  Future<int?> getTotalCashTransaction() async{
    final Database db = await database;

    final records = await db.query(
      table,
      columns: ['SUM($Field4)'],
      where: '$Field6 = ?',
      whereArgs: ['Cash'],
    );
    var sum = Sqflite.firstIntValue(records);
    return sum;
  }

  Future<int?> getTotalBankTransaction() async{
    final Database db = await database;

    final records = await db.query(
      table,
      columns: ['SUM($Field4)'],
      where: '$Field6 = ?',
      whereArgs: ['Bank'],
    );
    var sum = Sqflite.firstIntValue(records);
    return sum;
  }
}