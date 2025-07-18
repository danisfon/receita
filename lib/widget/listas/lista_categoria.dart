import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/categoria_dao.dart';
import 'package:receita/dto/dto_categoria.dart';
import 'package:receita/configuracao/rotas.dart';

class ListaCategoria extends StatefulWidget {
  const ListaCategoria({super.key});

  @override
  State<ListaCategoria> createState() => _ListaCategoriaState();
}

class _ListaCategoriaState extends State<ListaCategoria> {
  final _dao = DAOCategoria();
  List<DTOCategoria> _categorias = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
  }

  Future<void> _carregarCategorias() async {
    try {
      final lista = await _dao.buscarTodos();
      setState(() {
        _categorias = lista;
        _carregando = false;
      });
    } catch (_) {
      setState(() => _carregando = false);
    }
  }

  Future<void> _excluirCategoria(int id) async {
    await _dao.excluir(id);
    _carregarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _carregarCategorias,
          )
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _categorias.isEmpty
              ? const Center(child: Text('Nenhuma categoria cadastrada'))
              : ListView.builder(
                  itemCount: _categorias.length,
                  itemBuilder: (context, index) {
                    final categoria = _categorias[index];
                    return ListTile(
                      title: Text(categoria.nome),
                      // Removido o subtitle que usava categoria.ativo
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Rotas.cadastroCategoria,
                                arguments: categoria,
                              ).then((_) => _carregarCategorias());
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _excluirCategoria(categoria.id!),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroCategoria)
            .then((_) => _carregarCategorias()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
