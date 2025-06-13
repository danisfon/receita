import '/banco/sqlite/conexao.dart';
import '/dto/dto_tag.dart';
import 'package:sqflite/sqflite.dart';

class DAOTag {
  final String sqlInserir = '''
    INSERT INTO Tag (
      nome
    ) VALUES (?)
  ''';

  final String sqlAlterar = '''
    UPDATE Tag SET
      nome = ?
    WHERE id = ?
  ''';

  final String sqlConsultarTodos = '''
    SELECT * FROM Tag
  ''';

  final String sqlConsultarPorId = '''
    SELECT * FROM Tag WHERE id = ?
  ''';

  final String sqlExcluir = '''
    DELETE FROM Tag WHERE id = ?
  ''';

  Future<void> salvar(DTOTag tag) async {
    final db = await Conexao.get();
    if (tag.id == null) {
      await db.rawInsert(sqlInserir, [
        tag.nome,
      ]);
    } else {
      await db.rawUpdate(sqlAlterar, [tag.nome, tag.id]);
    }
  }

  Future<List<DTOTag>> consultarTodos() async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarTodos);
    return resultado.map((map) => mapToDTO(map)).toList();
  }

  Future<DTOTag?> consultarPorId(int id) async {
    final db = await Conexao.get();
    final resultado = await db.rawQuery(sqlConsultarPorId, [id]);
    if (resultado.isEmpty) return null;
    return mapToDTO(resultado.first);
  }

  Future<void> excluir(int id) async {
    final db = await Conexao.get();
    await db.rawDelete(sqlExcluir, [id]);
  }

  DTOTag mapToDTO(Map<String, dynamic> map) {
    return DTOTag(
      id: map['id'] as String?,
      nome: map['nome'] as String,
    );
  }

  Map<String, dynamic> dtoToMap(DTOTag dto) {
    return {
      'id': dto.id,
      'nome': dto.nome,
    };
  }
}
