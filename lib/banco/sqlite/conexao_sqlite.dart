import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:path/path.dart';
import 'script.dart';

class ConexaoSQLite {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _inicializarBanco();
    return _database!;
  }

  static Future<Database> _inicializarBanco() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    String path;
    if (kIsWeb) {
      path = 'receitas_app.db';
    } else {
      String databasesPath = await databaseFactory.getDatabasesPath();
      path = join(databasesPath, 'receitas_app.db');
    }

    // Você pode remover essa linha depois do desenvolvimento:
    // deleteDatabase(path); // 🔧 opcional: apaga o banco a cada execução

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _criarTabelas,
        onUpgrade: _atualizarBanco,
      ),
    );
  }

  static Future<void> _criarTabelas(Database db, int version) async {
    for (String comando in ScriptSQLite.comandosCriarTabelas) {
      await db.execute(comando);
    }

    for (List<String> insercoes in ScriptSQLite.comandosInsercoes) {
      for (String comando in insercoes) {
        await db.execute(comando);
      }
    }
  }

  static Future<void> _atualizarBanco(Database db, int oldVersion, int newVersion) async {
    // Lógica de migração futura
  }

  static Future<void> fecharConexao() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
