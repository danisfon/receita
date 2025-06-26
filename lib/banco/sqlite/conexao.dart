import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

// IMPORTANTE: importe os comandos
import 'bd_tabelas.dart'; // ajuste o caminho conforme sua pasta

class Conexao {
  static Database? _db;

  static Future<Database> get() async {
    if (_db != null) return _db!;

    try {
      if (kIsWeb) {
        databaseFactory = databaseFactoryFfiWeb;
        _db = await databaseFactory.openDatabase('db_web.sqlite');
        await _executarInstrucoes(_db!);
        return _db!;
      }

      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'app.db');

      await deleteDatabase(path); // Reset do banco

      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await _executarInstrucoes(db);
        },
      );

      return _db!;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> _executarInstrucoes(Database db) async {
    for (final sql in criarTabelas) {
      await db.execute(sql);
    }

    for (final insert in inserirReceitas) {
      await db.execute(insert);
    }
  }
}
