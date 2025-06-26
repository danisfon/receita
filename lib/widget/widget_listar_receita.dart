import 'package:flutter/material.dart';
import 'package:flutter_application_1/dao/dao_receita.dart';
import 'package:flutter_application_1/dto/dto_receita.dart';


class ListaReceitas extends StatefulWidget {
  @override
  _ListaReceitasState createState() => _ListaReceitasState();
}

class _ListaReceitasState extends State<ListaReceitas> {
  List<DTOReceita> _receitas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarReceitas();
  }

  Future<void> _carregarReceitas() async {
    try {
      final dao = ReceitaDAO();
      final receitas = await dao.listarTodos();
      setState(() {
        _receitas = receitas;
        _carregando = false;
      });
    } catch (e) {
      setState(() {
        _carregando = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar receitas: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas Cadastradas'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: _carregando
          ? Center(child: CircularProgressIndicator())
          : _receitas.isEmpty
              ? Center(child: Text('Nenhuma receita cadastrada'))
              : ListView.builder(
                  itemCount: _receitas.length,
                  itemBuilder: (context, index) {
                    final receita = _receitas[index];

                    // Quebra os ingredientes da string (trigo;leite;açúcar) para lista
                    final ingredientes = receita.ingredientes.split(';');

                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ExpansionTile(
                        title: Text(
                          receita.nome,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children: ingredientes
                            .map(
                              (ingrediente) => ListTile(
                                title: Text(ingrediente),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
    );
  }
}
