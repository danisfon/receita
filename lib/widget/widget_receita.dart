import 'package:flutter/material.dart';
import 'package:flutter_application_1/dao/dao_receita.dart';
import 'package:flutter_application_1/dto/dto_receita.dart';

class CadastrarReceita extends StatefulWidget {
  @override
  _CadastrarReceitaState createState() => _CadastrarReceitaState();
}

class _CadastrarReceitaState extends State<CadastrarReceita> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _campoNomeReceita = TextEditingController();
  final TextEditingController _campoIngrediente1 = TextEditingController();
  final TextEditingController _campoIngrediente2 = TextEditingController();
  final TextEditingController _campoIngrediente3 = TextEditingController();

  final List<String> _tagsDisponiveis = [
    'Doce',
    'Salgado',
    'Fitness',
    'Vegetariana',
    'Vegana',
    'Rápida',
    'Low Carb',
  ];

  final List<String> _tagsSelecionadas = [];

  void _mostrarSelecaoDeTags() {
    showDialog(
      context: context,
      builder: (context) {
        List<String> selecionadasTemp = List.from(_tagsSelecionadas);
        return AlertDialog(
          title: Text('Selecionar Tags'),
          content: SingleChildScrollView(
            child: Column(
              children: _tagsDisponiveis.map((tag) {
                return StatefulBuilder(
                  builder: (context, setStateDialog) => CheckboxListTile(
                    value: selecionadasTemp.contains(tag),
                    title: Text(tag),
                    onChanged: (bool? valor) {
                      setStateDialog(() {
                        if (valor == true) {
                          selecionadasTemp.add(tag);
                        } else {
                          selecionadasTemp.remove(tag);
                        }
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _tagsSelecionadas.clear();
                  _tagsSelecionadas.addAll(selecionadasTemp);
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _salvarReceita() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final nomeReceita = _campoNomeReceita.text.trim();

    // Junta os ingredientes separados por ';'
    final ingredientes = [
      _campoIngrediente1.text.trim(),
      _campoIngrediente2.text.trim(),
      _campoIngrediente3.text.trim(),
    ].where((ing) => ing.isNotEmpty).join(';');

    // Junta as tags selecionadas por ';'
    final tags = _tagsSelecionadas.join(';');

    if (ingredientes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha pelo menos um ingrediente')),
      );
      return;
    }

    // Crie um DTOReceita (assumindo que o DTO aceite ingredientes e tags como string)
    final receita = DTOReceita(
      nome: nomeReceita,
      ingredientes: ingredientes,
      tags: tags,
    );

    try {
      final dao = ReceitaDAO();
      await dao.inserir(receita);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Receita salva com sucesso!')),
      );

      _formKey.currentState!.reset();
      _campoNomeReceita.clear();
      _campoIngrediente1.clear();
      _campoIngrediente2.clear();
      _campoIngrediente3.clear();

      setState(() {
        _tagsSelecionadas.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar receita: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Receita'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _campoNomeReceita,
              decoration: const InputDecoration(
                labelText: 'Nome da Receita',
                border: OutlineInputBorder(),
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Preencha o nome da receita';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text('Ingredientes', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              controller: _campoIngrediente1,
              decoration: const InputDecoration(
                labelText: 'Ingrediente 1',
                border: OutlineInputBorder(),
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Preencha este ingrediente';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _campoIngrediente2,
              decoration: const InputDecoration(
                labelText: 'Ingrediente 2',
                border: OutlineInputBorder(),
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Preencha este ingrediente';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _campoIngrediente3,
              decoration: const InputDecoration(
                labelText: 'Ingrediente 3',
                border: OutlineInputBorder(),
              ),
              validator: (valor) {
                if (valor == null || valor.trim().isEmpty) {
                  return 'Preencha este ingrediente';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text('Tags', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            InkWell(
              onTap: _mostrarSelecaoDeTags,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Selecione as Tags',
                  border: OutlineInputBorder(),
                ),
                child: Wrap(
                  spacing: 8,
                  children: _tagsSelecionadas.isEmpty
                      ? [Text('Nenhuma tag selecionada')]
                      : _tagsSelecionadas
                          .map((tag) => Chip(label: Text(tag)))
                          .toList(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: _salvarReceita,
                child: Text('Salvar Receita'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
