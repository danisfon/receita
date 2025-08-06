import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/conexao_sqlite.dart';

class ListaReceitasPorCategoria extends StatefulWidget {
  final int categoriaId;
  final String nomeCategoria;

  const ListaReceitasPorCategoria({
    super.key,
    required this.categoriaId,
    required this.nomeCategoria,
  });

  @override
  State<ListaReceitasPorCategoria> createState() =>
      _ListaReceitasPorCategoriaState();
}

class _ListaReceitasPorCategoriaState extends State<ListaReceitasPorCategoria> {
  bool _carregando = true;
  bool _erro = false;
  List<Map<String, dynamic>> _dados = [];

  @override
  void initState() {
    super.initState();
    _buscarReceitasComIngredientes();
  }

  Future<void> _buscarReceitasComIngredientes() async {
    try {
      final db = await ConexaoSQLite.database;

      final resultado = await db.rawQuery('''
        SELECT 
          r.id AS receita_id,
          r.nome AS receita_nome,
          i.nome AS ingrediente_nome
        FROM receita r
        LEFT JOIN receita_ingrediente ri ON ri.receita_id = r.id
        LEFT JOIN ingrediente i ON i.id = ri.ingrediente_id
        WHERE r.categoria_id = ?
        ORDER BY r.nome, i.nome
      ''', [widget.categoriaId]);

      setState(() {
        _dados = resultado;
        _carregando = false;
        _erro = false;
      });
    } catch (_) {
      setState(() {
        _erro = true;
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_erro) {
      return Scaffold(
        appBar: AppBar(title: Text('Receitas - ${widget.nomeCategoria}')),
        body: const Center(child: Text('Erro ao carregar os dados.')),
      );
    }

    if (_carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Agrupar ingredientes por receita
    final Map<String, List<String>> receitasMap = {};
    for (var linha in _dados) {
      final nomeReceita = linha['receita_nome'] ?? 'Desconhecida';
      final nomeIngrediente = linha['ingrediente_nome'] ?? 'Nenhum';

      receitasMap.putIfAbsent(nomeReceita, () => []);
      if (nomeIngrediente != 'Nenhum') {
        receitasMap[nomeReceita]!.add(nomeIngrediente);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Receitas - ${widget.nomeCategoria}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: receitasMap.entries.map((entry) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(entry.key,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(entry.value.isEmpty
                  ? 'Nenhum ingrediente'
                  : entry.value.join(', ')),
            ),
          );
        }).toList(),
      ),
    );
  }
}
