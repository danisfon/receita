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

  Map<int, List<DTOReceitaIngrediente>> _agruparPorReceita(List<DTOReceitaIngrediente> lista) {
    final Map<int, List<DTOReceitaIngrediente>> mapa = {};
    for (var item in lista) {
      mapa.putIfAbsent(item.receitaId, () => []).add(item);
    }
    return mapa;
  }

  @override
  Widget build(BuildContext context) {
    final agrupados = _agruparPorReceita(_lista);

    return Scaffold(
      appBar: AppBar(title: const Text('Ingredientes por Receita')),
      body: ListView(
        children: agrupados.entries.map((entrada) {
          final ingredientes = entrada.value;
          final nomeReceita = ingredientes.first.nomeReceita ?? 'Receita sem nome';

          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nomeReceita,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...ingredientes.map((i) {
                    final quantidade = i.quantidade?.toString() ?? '';
                    final unidade = i.unidade ?? '';
                    final nomeIng = i.nomeIngrediente ?? '';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text('- $quantidade $unidade $nomeIng'),
                    );
                  }),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editar(ingredientes.first),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _excluir(ingredientes.first),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroReceitaIngrediente)
            .then((_) => _carregarDados()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
