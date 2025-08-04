import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/banco/sqlite/dao/autor_receita_favorita_dao.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/dto/dto_receita.dart';
import 'package:receita/dto/dto_autor_receita_favorita.dart';
import 'package:receita/widget/form_autor_receita_favorita.dart';

class ListaAutorReceitaFavorita extends StatefulWidget {
  const ListaAutorReceitaFavorita({super.key});

  @override
  State<ListaAutorReceitaFavorita> createState() => _ListaAutorReceitaFavoritaState();
}

class _ListaAutorReceitaFavoritaState extends State<ListaAutorReceitaFavorita> {
  List<DTOAutorReceitaFavorita> _favoritos = [];
  Map<int, DTOAutor> _mapaAutores = {};
  Map<int, DTOReceita> _mapaReceitas = {};

  @override
  void initState() {
    super.initState();
    _carregarFavoritos();
  }

  Future<void> _carregarFavoritos() async {
    final favoritos = await DAOAutorReceitaFavorita().buscarTodos();
    final autores = await DAOAutor().buscarTodos();
    final receitas = await DAOReceita().buscarTodos();

    setState(() {
      _favoritos = favoritos;
      _mapaAutores = {for (var a in autores) a.id!: a};
      _mapaReceitas = {for (var r in receitas) r.id!: r};
    });
  }

  Future<void> _excluir(int id) async {
    await DAOAutorReceitaFavorita().excluirPorId(id);
    await _carregarFavoritos();
  }

  void _abrirFormulario({DTOAutorReceitaFavorita? favorito}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormAutorReceitaFavorita(favorito: favorito),
      ),
    );
    await _carregarFavoritos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas Favoritas dos Autores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _abrirFormulario(),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _favoritos.length,
        itemBuilder: (_, index) {
          final fav = _favoritos[index];
          final autor = _mapaAutores[fav.autorId];
          final receita = _mapaReceitas[fav.receitaId];

          return ListTile(
            title: Text('${autor?.nome ?? "Autor desconhecido"}'),
            subtitle: Text('❤️ ${receita?.nome ?? "Receita desconhecida"}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _abrirFormulario(favorito: fav),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _excluir(fav.id!),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
