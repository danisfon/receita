import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_receita.dart';

class DAOReceita {
  static const String _tabela = 'receita';

  Future<int> salvar(DTOReceita receita) async {
    final db = await ConexaoSQLite.database;

    final dados = {
      'nome': receita.nome,
      'modo_preparo': receita.modoPreparo,
      'tempo_preparo': receita.tempoPreparo,
      'categoria_id': receita.categoriaId,
      'autor_id': receita.autorId,
    };

    if (receita.id != null) {
      return await db.update(_tabela, dados, where: 'id = ?', whereArgs: [receita.id]);
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  Future<List<DTOReceita>> buscarTodos() async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela);

    return resultado.map((linha) {
      return DTOReceita(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        modoPreparo: linha['modo_preparo'] as String,
        tempoPreparo: linha['tempo_preparo'] as int?,
        categoriaId: linha['categoria_id'] as int,
        autorId: linha['autor_id'] as int,
      );
    }).toList();
  }

  Future<DTOReceita?> buscarPorId(int id) async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela, where: 'id = ?', whereArgs: [id]);

    if (resultado.isNotEmpty) {
      final linha = resultado.first;
      return DTOReceita(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        modoPreparo: linha['modo_preparo'] as String,
        tempoPreparo: linha['tempo_preparo'] as int?,
        categoriaId: linha['categoria_id'] as int,
        autorId: linha['autor_id'] as int,
      );
    }
    return null;
  }

  Future<int> excluir(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
