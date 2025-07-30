import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_autor_receita_favorita.dart';

class DAOAutorReceitaFavorita {
  static const String _tabela = 'autor_receita_favorita';

  Future<int> salvar(DTOAutorReceitaFavorita favorito) async {
    final db = await ConexaoSQLite.database;

    final dados = {
      'autor_id': favorito.autorId,
      'receita_id': favorito.receitaId,
    };

    if (favorito.id != null) {
      return await db.update(_tabela, dados, where: 'id = ?', whereArgs: [favorito.id]);
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  Future<List<DTOAutorReceitaFavorita>> buscarTodos() async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela);

    return resultado.map((linha) {
      return DTOAutorReceitaFavorita(
        id: linha['id'] as int?,
        autorId: linha['autor_id'] as int,
        receitaId: linha['receita_id'] as int,
      );
    }).toList();
  }

  Future<List<DTOAutorReceitaFavorita>> buscarPorAutor(int autorId) async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela, where: 'autor_id = ?', whereArgs: [autorId]);

    return resultado.map((linha) {
      return DTOAutorReceitaFavorita(
        id: linha['id'] as int?,
        autorId: linha['autor_id'] as int,
        receitaId: linha['receita_id'] as int,
      );
    }).toList();
  }

  Future<int> excluirPorId(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
