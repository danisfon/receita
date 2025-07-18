import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_ingrediente.dart';

class DAOIngrediente {
  static const String _tabela = 'ingrediente';

  Future<int> salvar(DTOIngrediente ingrediente) async {
    final db = await ConexaoSQLite.database;

    final dados = {
      'nome': ingrediente.nome,
      'tipo': ingrediente.tipo,
      'quantidade_padrao': ingrediente.quantidadePadrao,
      'unidade': ingrediente.unidade,
    };

    if (ingrediente.id != null) {
      return await db.update(_tabela, dados, where: 'id = ?', whereArgs: [ingrediente.id]);
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  Future<List<DTOIngrediente>> buscarTodos() async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela);

    return resultado.map((linha) {
      return DTOIngrediente(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        tipo: linha['tipo'] as String?,
        quantidadePadrao: linha['quantidade_padrao'] as double?,
        unidade: linha['unidade'] as String?,
      );
    }).toList();
  }

  Future<DTOIngrediente?> buscarPorId(int id) async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela, where: 'id = ?', whereArgs: [id]);

    if (resultado.isNotEmpty) {
      final linha = resultado.first;
      return DTOIngrediente(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        tipo: linha['tipo'] as String?,
        quantidadePadrao: linha['quantidade_padrao'] as double?,
        unidade: linha['unidade'] as String?,
      );
    }
    return null;
  }

  Future<int> excluir(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
