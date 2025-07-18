import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_receita_ingrediente.dart';

class DAOReceitaIngrediente {
  static const String _tabela = 'receita_ingrediente';

  Future<int> salvar(DTOReceitaIngrediente ri) async {
    final db = await ConexaoSQLite.database;

    final dados = {
      'receita_id': ri.receitaId,
      'ingrediente_id': ri.ingredienteId,
      'quantidade': ri.quantidade,
      'unidade': ri.unidade,
    };

    if (ri.id != null) {
      return await db.update(_tabela, dados, where: 'id = ?', whereArgs: [ri.id]);
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  Future<List<DTOReceitaIngrediente>> buscarTodos() async {
    final db = await ConexaoSQLite.database;

    // Faz join para pegar nomes das receitas e ingredientes
    final resultado = await db.rawQuery('''
      SELECT ri.id, ri.receita_id, ri.ingrediente_id, ri.quantidade, ri.unidade,
             r.nome AS nome_receita,
             i.nome AS nome_ingrediente
      FROM $_tabela ri
      INNER JOIN receita r ON ri.receita_id = r.id
      INNER JOIN ingrediente i ON ri.ingrediente_id = i.id
      ORDER BY r.nome, i.nome
    ''');

    return resultado.map((map) => DTOReceitaIngrediente.fromMap(map)).toList();
  }

  Future<int> excluir(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
