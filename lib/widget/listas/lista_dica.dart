import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/dica_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_dica.dart';

class ListaDica extends StatefulWidget {
  const ListaDica({super.key});

  @override
  State<ListaDica> createState() => _ListaDicaState();
}

class _ListaDicaState extends State<ListaDica> {
  final DAODica _dao = DAODica();
  List<DTODica> _itens = [];
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
        title: const Text('Dicas Culinárias'),
        actions: [
          IconButton(
            onPressed: _carregar,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _itens.isEmpty
              ? const Center(child: Text('Nenhuma dica cadastrada'))
              : ListView.builder(
                  itemCount: _itens.length,
                  itemBuilder: (context, index) => _itemLista(_itens[index]),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, Rotas.cadastroDica).then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _itemLista(DTODica dto) {
    return Card(
      child: ListTile(
        title: Text(
          dto.nome,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(dto.descricao),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          tooltip: 'Excluir',
          onPressed: () => _excluir(dto),
        ),
        onTap: () => Navigator.pushNamed(
          context,
          Rotas.cadastroDica,
          arguments: dto,
        ).then((_) => _carregar()),
      ),
    );
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);
    _itens = await _dao.buscarTodos();
    setState(() => _carregando = false);
  }

  Future<void> _excluir(DTODica dto) async {
    await _dao.excluirPorId(dto.id!);
    _carregar();
  }
}
