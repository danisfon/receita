import 'package:receita/banco/sqlite/conexao_sqlite.dart';
import 'package:receita/dto/dto_autor_rede_social.dart';

class DAOAutorRedeSocial {
  static const String _tabela = 'autor_rede_social';

  Future<int> salvar(DTOAutorRedeSocial ars) async {
    final db = await ConexaoSQLite.database;

    final dados = {
      'autor_id': ars.autorId,
      'rede': ars.rede,
      'url': ars.url,
    };

    if (ars.id != null) {
      return await db.update(_tabela, dados, where: 'id = ?', whereArgs: [ars.id]);
    } else {
      return await db.insert(_tabela, dados);
    }
  }

  Future<List<DTOAutorRedeSocial>> buscarPorAutor(int autorId) async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela, where: 'autor_id = ?', whereArgs: [autorId]);

    return resultado.map((linha) {
      return DTOAutorRedeSocial(
        id: linha['id'] as int?,
        autorId: linha['autor_id'] as int,
        rede: linha['rede'] as String,
        url: linha['url'] as String,
      );
    }).toList();
  }

  Future<List<DTOAutorRedeSocial>> buscarTodos() async {
    final db = await ConexaoSQLite.database;
    final resultado = await db.query(_tabela);

    return resultado.map((linha) {
      return DTOAutorRedeSocial(
        id: linha['id'] as int?,
        autorId: linha['autor_id'] as int,
        rede: linha['rede'] as String,
        url: linha['url'] as String,
      );
    }).toList();
  }

  Future<int> excluirPorId(int id) async {
    final db = await ConexaoSQLite.database;
    return await db.delete(_tabela, where: 'id = ?', whereArgs: [id]);
  }
}
