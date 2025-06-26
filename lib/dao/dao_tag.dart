import 'package:flutter_application_1/banco/sqlite/conexao.dart';
import 'package:flutter_application_1/dto/dto_tag.dart';
import 'package:sqflite/sqflite.dart';

class TagDAO {
  Future<int> inserir(DTOTag tag) async {
    final db = await Conexao.get();
    return await db.insert(
      'Tag',
      {
        'nome': tag.nome,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DTOTag>> listarTodos() async {
    final db = await Conexao.get();
    final resultado = await db.query('Tag');
    return resultado.map((map) => DTOTag(
      id: map['id'] as int?,
      nome: map['nome'] as String,
    )).toList();
  }

  Future<DTOTag?> buscarPorId(int id) async {
    final db = await Conexao.get();
    final resultado = await db.query(
      'Tag',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (resultado.isNotEmpty) {
      final map = resultado.first;
      return DTOTag(
        id: map['id'] as int?,
        nome: map['nome'] as String,
      );
    }
    return null;
  }

  Future<int> atualizar(DTOTag tag) async {
    if (tag.id == null) {
      throw Exception('ID da tag é obrigatório para atualizar');
    }
    final db = await Conexao.get();
    return await db.update(
      'Tag',
      {
        'nome': tag.nome,
      },
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  Future<int> deletar(int id) async {
    final db = await Conexao.get();
    return await db.delete(
      'Tag',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
