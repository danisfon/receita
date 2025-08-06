import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_comentario.dart';
import 'package:sqflite/sqflite.dart';

class DAOComentario {
  Future<void> inserir(DTOComentario dto) async {
    final Database db = await ConexaoSQLite.database;
    await db.insert('comentario', dto.toMap());
  }

  Future<void> atualizar(DTOComentario dto) async {
    final Database db = await ConexaoSQLite.database;
    await db.update(
      'comentario',
      dto.toMap(),
      where: 'id = ?',
      whereArgs: [dto.id],
    );
  }

  Future<void> excluir(int id) async {
    final Database db = await ConexaoSQLite.database;
    await db.delete('comentario', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOComentario>> buscarTodos() async {
    final Database db = await ConexaoSQLite.database;
    final List<Map<String, dynamic>> maps = await db.query('comentario');
    return maps.map((map) => DTOComentario.fromMap(map)).toList();
  }
}
