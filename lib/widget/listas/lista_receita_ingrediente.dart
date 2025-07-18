import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/receita_ingrediente_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_receita_ingrediente.dart';

class ListaReceitaIngrediente extends StatefulWidget {
  const ListaReceitaIngrediente({super.key});

  @override
  State<ListaReceitaIngrediente> createState() => _ListaReceitaIngredienteState();
}

class _ListaReceitaIngredienteState extends State<ListaReceitaIngrediente> {
  final _dao = DAOReceitaIngrediente();
  List<DTOReceitaIngrediente> _lista = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final dados = await _dao.buscarTodos();
    setState(() => _lista = dados);
  }

  void _editar(DTOReceitaIngrediente item) {
    Navigator.pushNamed(context, Rotas.cadastroReceitaIngrediente, arguments: item)
        .then((_) => _carregarDados());
  }

  void _excluir(DTOReceitaIngrediente item) async {
    await _dao.excluir(item.id!);
    _carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingredientes por Receita')),
      body: ListView.builder(
        itemCount: _lista.length,
        itemBuilder: (_, i) {
          final item = _lista[i];
          return ListTile(
            title: Text('Receita: ${item.nomeReceita ?? '---'}'),
            subtitle: Text('Ingrediente: ${item.nomeIngrediente ?? '---'} | Quantidade: ${item.quantidade ?? 0} ${item.unidade ?? ''}'),
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
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroReceitaIngrediente)
            .then((_) => _carregarDados()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
