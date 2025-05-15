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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
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
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _campoNomeReceita.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Receita salva com sucesso!')),
                    );

                    setState(() {
                      _ingrediente1 = '';
                      _ingrediente2 = '';
                      _ingrediente3 = '';
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
