import 'package:flutter/material.dart';

class CadastrarReceita extends StatefulWidget {
  @override
  _CadastrarReceitaState createState() => _CadastrarReceitaState();
}

class _CadastrarReceitaState extends State<CadastrarReceita> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _campoNomeReceita = TextEditingController();

  String _nomeReceita = '';
  String _ingrediente1 = '';
  String _ingrediente2 = '';
  String _ingrediente3 = '';

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
                return CheckboxListTile(
                  value: selecionadasTemp.contains(tag),
                  title: Text(tag),
                  onChanged: (bool? valor) {
                    setState(() {
                      if (valor == true) {
                        selecionadasTemp.add(tag);
                      } else {
                        selecionadasTemp.remove(tag);
                      }
                    });
                  },
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
                if (valor == null || valor.isEmpty) {
                  return 'Preencha o nome da receita';
                }
                return null;
              },
              onSaved: (novoValor) {
                _nomeReceita = novoValor!;
              },
            ),
            const SizedBox(height: 20),
            Text('Ingredientes', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ingrediente 1',
                border: OutlineInputBorder(),
              ),
              validator: (valor) {
                if (valor == null) {
                  return 'Preencha este ingrediente';
                }
                return null;
              },
              onSaved: (valor) {
                _ingrediente1 = valor!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ingrediente 2',
                border: OutlineInputBorder(),
              ),
              validator: (valor) {
                if (valor == null) {
                  return 'Preencha este ingrediente';
                }
                return null;
              },
              onSaved: (valor) {
                _ingrediente2 = valor!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ingrediente 3',
                border: OutlineInputBorder(),
              ),
              validator: (valor) {
                if (valor == null) {
                  return 'Preencha este ingrediente';
                }
                return null;
              },
              onSaved: (valor) {
                _ingrediente3 = valor!;
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _campoNomeReceita.clear();

                    ScaffoldMessenger.of(context).showSnackBar(

                      SnackBar(
                        content: Text(
                          'Receita salva com sucesso!\nTags: ${_tagsSelecionadas.join(', ')}',
                        ),
                      ),
                    );

                    setState(() {
                      _ingrediente1 = '';
                      _ingrediente2 = '';
                      _ingrediente3 = '';
                      _tagsSelecionadas.clear();
                    });
                  }
                },
                child: Text('Salvar Receita'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
