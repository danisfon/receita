import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Conexao {
  static Database? _db;

  static Future<Database> get() async {
    if (_db != null) return _db!;

    try {
      if (kIsWeb) {
        databaseFactory = databaseFactoryFfiWeb;
        _db = await databaseFactory.openDatabase('db_web.sqlite');
        await _criarTabelasEInserts();
        return _db!;
      }

      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'app.db');

      await deleteDatabase(path);

      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await _criarTabelasEInserts(db);
        },
      );
      return _db!;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> _criarTabelasEInserts([Database? db]) async {
    final Database database = db ?? _db!;

    final List<String> criarTabelas = [
      '''
        CREATE TABLE IF NOT EXISTS Receita (
          id TEXT PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          ingredientes TEXT NOT NULL,
          tags TEXT NOT NULL
        )
      ''',
      '''
        CREATE TABLE IF NOT EXISTS Tag (
          id TEXT PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL
        )
      '''
    ];

    for (final sql in criarTabelas) {
      await database.execute(sql);
    }

    final List<String> insertsIniciais = [
      "INSERT INTO Tag (nome) VALUES ('Doce')",
      "INSERT INTO Tag (nome) VALUES ('Fitness')",
      "INSERT INTO Tag (nome) VALUES ('Rápida')",
      "INSERT INTO Tag (nome) VALUES ('Vegana')",
      "INSERT INTO Receita (nome, ingredientes, tags) VALUES ('Bolo de Chocolate', 'Farinha,Açúcar,Ovo', 'Doce,Fitness')",
      "INSERT INTO Receita (nome, ingredientes, tags) VALUES ('Salada de Frutas', 'Maçã,Banana,Melancia', 'Fitness,Vegana')"
    ];

    for (final insert in insertsIniciais) {
      await database.execute(insert);
    }
  }
}
