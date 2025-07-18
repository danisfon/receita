import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/utensilio_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_utensilio.dart';

class ListaUtensilio extends StatefulWidget {
  const ListaUtensilio({super.key});

  @override
  State<ListaUtensilio> createState() => _ListaUtensilioState();
}

class _ListaUtensilioState extends State<ListaUtensilio> {
  final _dao = DAOUtensilio();
  List<DTOUtensilio> _utensilios = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final lista = await _dao.buscarTodos();
    setState(() {
      _utensilios = lista;
    });
  }

  void _editar(DTOUtensilio item) {
    Navigator.pushNamed(context, Rotas.cadastroUtensilio, arguments: item)
        .then((_) => _carregarDados());
  }

  void _excluir(DTOUtensilio item) async {
    await _dao.excluir(item.id!);
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Utensílios')),
      body: ListView.builder(
        itemCount: _utensilios.length,
        itemBuilder: (_, i) {
          final item = _utensilios[i];
          return ListTile(
            title: Text(item.nome),
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
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroUtensilio)
            .then((_) => _carregarDados()),
        child: const Icon(Icons.add),
      ),
    );
  }
}