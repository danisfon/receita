import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_dica.dart';

class DAODica {
  static const String _tabela = 'dica';

  Future<int> salvar(DTODica dica) async {
    final db = await ConexaoSQLite.database;
    final dados = {
      'titulo': dica.titulo,
      'descricao': dica.descricao,
      'autor_id': dica.autorId,
    };

    if (dica.id != null) {
      return await db.update(_tabela, dados, where: 'id = ?', whereArgs: [dica.id]);
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  Future<List<DTODica>> buscarTodos() async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela);

    return resultado.map((linha) {
      return DTODica(
        id: linha['id'] as int,
        titulo: linha['titulo'] as String,
        descricao: linha['descricao'] as String,
        autorId: linha['autor_id'] as int,
      );
    }).toList();
  }

  Future<int> excluirPorId(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
