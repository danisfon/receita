import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_dica.dart';

class DAODica {
  static const String _tabela = 'dica';

  Future<int> salvar(DTODica dica) async {
    final db = await ConexaoSQLite.database;

    final dados = {
      'titulo': dica.nome,
      'descricao': dica.descricao ?? '',
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
        id: linha['id'] as int?,
        nome: linha['titulo'] as String,
        descricao: linha['descricao'] as String,
      );
    }).toList();
  }

  Future<DTODica?> buscarPorId(int id) async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela, where: 'id = ?', whereArgs: [id]);

    if (resultado.isNotEmpty) {
      final linha = resultado.first;
      return DTODica(
        id: linha['id'] as int?,
        nome: linha['titulo'] as String,
        descricao: linha['descricao'] as String,
      );
    }
    return null;
  }

  Future<int> excluir(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
