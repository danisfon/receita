import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_receita.dart';

class ListaReceita extends StatefulWidget {
  const ListaReceita({super.key});

  @override
  State<ListaReceita> createState() => _ListaReceitaState();
}

class _ListaReceitaState extends State<ListaReceita> {
  final _dao = DAOReceita();
  List<DTOReceita> _receitas = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final lista = await _dao.buscarTodos();
    setState(() {
      _receitas = lista;
    });
  }

  void _editar(DTOReceita item) {
    Navigator.pushNamed(context, Rotas.cadastroReceita, arguments: item)
        .then((_) => _carregarDados());
  }

  void _excluir(DTOReceita item) async {
    await _dao.excluir(item.id!);
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receitas')),
      body: ListView.builder(
        itemCount: _receitas.length,
        itemBuilder: (_, i) {
          final item = _receitas[i];
          return ListTile(
            title: Text(item.nome),
            subtitle: Text(item.modoPreparo ?? ''),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editar(item),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _excluir(item),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroReceita)
            .then((_) => _carregarDados()),
        child: const Icon(Icons.add),
      ),
    );
  }
}