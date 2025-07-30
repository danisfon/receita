import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/dao_autor.dart';
import 'package:receita/banco/sqlite/dao/dao_receita.dart';
import 'package:receita/banco/sqlite/dao/dao_autor_receita_favorita.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/dto/dto_receita.dart';
import 'package:receita/dto/dto_autor_receita_favorita.dart';

class FormAutorReceitaFavorita extends StatefulWidget {
  final DTOAutorReceitaFavorita? favorito;

  const FormAutorReceitaFavorita({super.key, this.favorito});

  @override
  State<FormAutorReceitaFavorita> createState() => _FormAutorReceitaFavoritaState();
}

class _FormAutorReceitaFavoritaState extends State<FormAutorReceitaFavorita> {
  final _formKey = GlobalKey<FormState>();

  int? _autorId;
  int? _receitaId;

  List<DTOAutor> _autores = [];
  List<DTOReceita> _receitas = [];

  @override
  void initState() {
    super.initState();
    _carregarDados();
    if (widget.favorito != null) {
      _autorId = widget.favorito!.autorId;
      _receitaId = widget.favorito!.receitaId;
    }
  }

  Future<void> _carregarDados() async {
    final autores = await DAOAutor().buscarTodos();
    final receitas = await DAOReceita().buscarTodos();
    setState(() {
      _autores = autores;
      _receitas = receitas;
    });
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      final favorito = DTOAutorReceitaFavorita(
        id: widget.favorito?.id,
        autorId: _autorId!,
        receitaId: _receitaId!,
      );
      await DAOAutorReceitaFavorita().salvar(favorito);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.favorito == null ? 'Nova Receita Favorita' : 'Editar Receita Favorita'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                value: _autorId,
                items: _autores
                    .map((autor) => DropdownMenuItem(
                          value: autor.id,
                          child: Text(autor.nome),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _autorId = value),
                decoration: const InputDecoration(labelText: 'Autor'),
                validator: (value) => value == null ? 'Selecione o autor' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _receitaId,
                items: _receitas
                    .map((receita) => DropdownMenuItem(
                          value: receita.id,
                          child: Text(receita.nome),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _receitaId = value),
                decoration: const InputDecoration(labelText: 'Receita'),
                validator: (value) => value == null ? 'Selecione a receita' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
