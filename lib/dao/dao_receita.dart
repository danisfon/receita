import '/banco/sqlite/conexao.dart';
import '/dto/dto_receita.dart';
import 'package:sqflite/sqflite.dart';

class DAOReceita {
  final String sqlInserir = '''
    INSERT INTO Receita (
      nome, ingredientes, tags
    ) VALUES (?, ?, ?)
  ''';

  final String sqlAlterar = '''
    UPDATE Receita SET
      nome = ?, ingredientes = ?, tags = ?
    WHERE id = ?
  ''';

  final String sqlConsultarTodos = '''
    SELECT * FROM Receita
  ''';

  final String sqlConsultarPorId = '''
    SELECT * FROM Receita WHERE id = ?
  ''';

  final String sqlExcluir = '''
    DELETE FROM Receita WHERE id = ?
  ''';

  Future<void> salvar(DTOReceita receita) async {
    final db = await Conexao.get();
    if (receita.id == null) {
      await db.rawInsert(sqlInserir, [
        receita.nome,
        receita.ingredientes.join(
            ','),
        receita.tags.join(
            ',') 
      ]);
    } else {
      await db.rawUpdate(sqlAlterar, [
        receita.nome,
        receita.ingredientes.join(','),
        receita.tags.join(','),
        receita.id
      ]);
    }
  }

  Future<List<DTOReceita>> consultarTodos() async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarTodos);
    return resultado.map((map) => mapToDTO(map)).toList();
  }

  Future<DTOReceita?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarPorId, [id]);
    if (resultado.isEmpty) return null;
    return mapToDTO(resultado.first);
  }

  Future<void> excluir(int id) async {
    final db = await Conexao.get();
    await db.rawDelete(sqlExcluir, [id]);
  }

  DTOReceita mapToDTO(Map<String, dynamic> map) {
    return DTOReceita(
      id: map['id'] as String?,
      nome: map['nome'] as String,
      ingredientes: (map['ingredientes'] as String).split(','),
      tags: (map['tags'] as String).split(','),
    );
  }

  Map<String, dynamic> dtoToMap(DTOReceita dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
      'ingredientes': dto.ingredientes.join(','),
      'tags': dto.tags.join(','),
    };
  }
}
