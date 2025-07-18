import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_utensilio.dart';

class DAOUtensilio {
  static const String _tabela = 'utensilio';

  Future<int> salvar(DTOUtensilio utensilio) async {
    final db = await ConexaoSQLite.database;

    final dados = {
      'nome': utensilio.nome,
      'material': utensilio.material,
      'observacao': utensilio.observacao,
    };

    if (utensilio.id != null) {
      return await db.update(_tabela, dados, where: 'id = ?', whereArgs: [utensilio.id]);
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  Future<List<DTOUtensilio>> buscarTodos() async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela);

    return resultado.map((linha) {
      return DTOUtensilio(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        material: linha['material'] as String?,
        observacao: linha['observacao'] as String?,
      );
    }).toList();
  }

  Future<DTOUtensilio?> buscarPorId(int id) async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela, where: 'id = ?', whereArgs: [id]);

    if (resultado.isNotEmpty) {
      final linha = resultado.first;
      return DTOUtensilio(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        material: linha['material'] as String?,
        observacao: linha['observacao'] as String?,
      );
    }
    return null;
  }

  Future<int> excluir(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
