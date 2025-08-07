import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/comentario_dao.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_comentario.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/dto/dto_receita.dart';

class ListaComentario extends StatefulWidget {
  const ListaComentario({super.key});

  @override
  State<ListaComentario> createState() => _ListaComentarioState();
}

class _ListaComentarioState extends State<ListaComentario> {
  final DAOComentario _daoComentario = DAOComentario();
  final DAOReceita _daoReceita = DAOReceita();
  final DAOAutor _daoAutor = DAOAutor();

  List<DTOComentario> _comentarios = [];
  Map<int, String> _nomesReceitas = {};
  Map<int, String> _nomesAutores = {};
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comentários'),
        actions: [
          IconButton(
            onPressed: _carregar,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _comentarios.isEmpty
              ? const Center(child: Text('Nenhum comentário cadastrado'))
              : ListView.builder(
                  itemCount: _comentarios.length,
                  itemBuilder: (context, index) =>
                      _itemLista(_comentarios[index]),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          Rotas.cadastroComentario,
        ).then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _itemLista(DTOComentario comentario) {
    final nomeReceita =
        _nomesReceitas[comentario.receitaId] ?? 'Receita desconhecida';
    final nomeAutor = _nomesAutores[comentario.autorId] ?? 'Autor desconhecido';

    return Card(
      child: ListTile(
        title: Text(
          comentario.texto,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Receita: $nomeReceita • Autor: $nomeAutor'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: 'Excluir',
          onPressed: () => _excluir(comentario),
        ),
        onTap: () => Navigator.pushNamed(
          context,
          Rotas.cadastroComentario,
          arguments: comentario,
        ).then((_) => _carregar()),
      ),
    );
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);

    final comentarios = await _daoComentario.buscarTodos();
    final receitas = await _daoReceita.buscarTodos();
    final autores = await _daoAutor.buscarTodos();

    // Mapeia os nomes das receitas e autores por ID
    _nomesReceitas = {for (var r in receitas) r.id!: r.nome};
    _nomesAutores = {for (var a in autores) a.id!: a.nome};

    setState(() {
      _comentarios = comentarios;
      _carregando = false;
    });
  }

  Future<void> _excluir(DTOComentario comentario) async {
    await _daoComentario.excluir(comentario.id!);
    _carregar();
  }
}
