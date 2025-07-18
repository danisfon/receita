import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/ingrediente_dao.dart';
import 'package:receita/dto/dto_ingrediente.dart';
import 'package:receita/configuracao/rotas.dart';

class ListaIngrediente extends StatefulWidget {
  const ListaIngrediente({super.key});

  @override
  State<ListaIngrediente> createState() => _ListaIngredienteState();
}

class _ListaIngredienteState extends State<ListaIngrediente> {
  final DAOIngrediente _dao = DAOIngrediente();
  List<DTOIngrediente> _itens = [];
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
        title: const Text('Ingredientes'),
        actions: [IconButton(onPressed: _carregar, icon: const Icon(Icons.refresh))],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _itens.isEmpty
              ? const Center(child: Text('Nenhum ingrediente cadastrado'))
              : ListView.builder(
                  itemCount: _itens.length,
                  itemBuilder: (context, index) => _itemLista(_itens[index]),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroIngrediente).then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _itemLista(DTOIngrediente dto) {
    return ListTile(
      title: Text(dto.nome),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () => _excluir(dto),
      ),
      onTap: () => Navigator.pushNamed(context, Rotas.cadastroIngrediente, arguments: dto).then((_) => _carregar()),
    );
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);
    _itens = await _dao.buscarTodos();
    setState(() => _carregando = false);
  }

  Future<void> _excluir(DTOIngrediente dto) async {
    await _dao.excluir(dto.id!);
    _carregar();
  }
}
