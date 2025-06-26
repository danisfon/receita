import 'package:flutter_application_1/banco/sqlite/conexao.dart';
import 'package:flutter_application_1/dto/dto_receita.dart';
import 'package:sqflite/sqflite.dart';

class ReceitaDAO {
Future<int> inserir(DTOReceita receita) async {
  final db = await Conexao.get();
  return await db.insert(
    'Receita',
    {
      'nome': receita.nome,
      'ingredientes': receita.ingredientes,
      'tags': receita.tags,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


  Future<List<DTOReceita>> listarTodos() async {
    final db = await Conexao.get();
    final resultado = await db.query('Receita');
    return resultado.map((map) => DTOReceita(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      ingredientes: map['ingredientes'] as String,
      tags: map['tags'] as String,
    )).toList();
  }

  Future<DTOReceita?> buscarPorId(int id) async {
    final db = await Conexao.get();
    final resultado = await db.query(
      'Receita',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (resultado.isNotEmpty) {
      final map = resultado.first;
      return DTOReceita(
        id: map['id'] as int?,
        nome: map['nome'] as String,
        ingredientes: map['ingredientes'] as String,
        tags: map['tags'] as String,
      );
    }
    return null;
  }

  Future<int> atualizar(DTOReceita receita) async {
    if (receita.id == null) {
      throw Exception('ID da receita é obrigatório para atualizar');
    }
    final db = await Conexao.get();
    return await db.update(
      'Receita',
      {
        'nome': receita.nome,
        'ingredientes': receita.ingredientes,
        'tags': receita.tags,
      },
      where: 'id = ?',
      whereArgs: [receita.id],
    );
  }

  Future<int> deletar(int id) async {
    final db = await Conexao.get();
    return await db.delete(
      'Receita',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
