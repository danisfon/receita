import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_categoria.dart';

class DAOCategoria {
  static const String _tabela = 'categoria';

  Future<int> salvar(DTOCategoria categoria) async {
    final db = await ConexaoSQLite.database;

    final dados = {
      'nome': categoria.nome,
      'descricao': categoria.descricao,
    };

    if (categoria.id != null) {
      return await db.update(
        _tabela,
        dados,
        where: 'id = ?',
        whereArgs: [categoria.id],
      );
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  Future<List<DTOCategoria>> buscarTodos() async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela);

    return resultado.map((linha) {
      return DTOCategoria(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        descricao: linha['descricao'] as String?,
      );
    }).toList();
  }

  Future<DTOCategoria?> buscarPorId(int id) async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(
      _tabela,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isNotEmpty) {
      final linha = resultado.first;
      return DTOCategoria(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        descricao: linha['descricao'] as String?,
      );
    }
    return null;
  }

  Future<int> excluir(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(
      _tabela,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
