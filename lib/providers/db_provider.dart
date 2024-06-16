import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:qr_scanner_sqlite/models/scan_model.dart';
export 'package:qr_scanner_sqlite/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    //path de la db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print('Database path: $path');

    //crear databae
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
    CREATE TABLE Scans(
      id INTEGER PRIMARY KEY,
      tipo TEXT,
      valor TEXT
    )
    ''');
    });
  }

  Future<int> newScanRaw(ScanModel scanModel) async {
    final id = scanModel.id;
    final tipo = scanModel.tipo;
    final valor = scanModel.valor;

    //get de la bd
    final db = await database;
    final res = await db.rawInsert('''
    INSERT INTO Scans(id,tipo,valor)
    VALUES ($id, '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> newScan(ScanModel newScan) async {
    final db = await database;
    final res = await db.insert('Scans', newScan.toJson());
    print(res);
    return res;
  }
}
