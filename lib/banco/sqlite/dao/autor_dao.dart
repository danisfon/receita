import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_autor.dart';

class DAOAutor {
  static const String _tabela = 'autor';

  Future<int> salvar(DTOAutor autor) async {
    final db = await ConexaoSQLite.database;

    final dados = {
      'nome': autor.nome,
      'email': autor.email,
      'bio': autor.bio,
    };

    if (autor.id != null) {
      return await db.update(_tabela, dados, where: 'id = ?', whereArgs: [autor.id]);
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  Future<List<DTOAutor>> buscarTodos() async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela);

    return resultado.map((linha) {
      return DTOAutor(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        email: linha['email'] as String,
        bio: linha['bio'] as String?,
      );
    }).toList();
  }

  Future<DTOAutor?> buscarPorId(int id) async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela, where: 'id = ?', whereArgs: [id]);

    if (resultado.isNotEmpty) {
      final linha = resultado.first;
      return DTOAutor(
        id: linha['id'] as int?,
        nome: linha['nome'] as String,
        email: linha['email'] as String,
        bio: linha['bio'] as String?,
      );
    }
    return null;
  }

  Future<int> excluir(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
