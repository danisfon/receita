import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/comentario_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_comentario.dart';

class ListaComentario extends StatefulWidget {
  const ListaComentario({super.key});

  @override
  State<ListaComentario> createState() => _ListaComentarioState();
}

class _ListaComentarioState extends State<ListaComentario> {
  final DAOComentario _dao = DAOComentario();
  List<DTOComentario> _comentarios = [];
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
    return Card(
      child: ListTile(
        title: Text(
          comentario.texto,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Receita ID: ${comentario.receitaId} • Autor ID: ${comentario.autorId}',
        ),
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
    _comentarios = await _dao.buscarTodos();
    setState(() => _carregando = false);
  }

  Future<void> _excluir(DTOComentario comentario) async {
    await _dao.excluir(comentario.id!);
    _carregar();
  }
}
