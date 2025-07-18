import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/dto/dto_receita.dart';
import 'package:receita/banco/sqlite/dao/categoria_dao.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/dto/dto_categoria.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';
import 'package:receita/widget/componentes/campos/comum/campo_dropdown.dart';

class FormReceita extends StatefulWidget {
  const FormReceita({super.key});

  @override
  State<FormReceita> createState() => _FormReceitaState();
}

class _FormReceitaState extends State<FormReceita> {
  final _formKey = GlobalKey<FormState>();
  final _daoReceita = DAOReceita();
  final _daoCategoria = DAOCategoria();
  final _daoAutor = DAOAutor();

  int? _id;
  bool _errorLoading = false;

  final _nomeController = TextEditingController();
  final _modoPreparoController = TextEditingController();

  List<DTOCategoria> _categorias = [];
  List<DTOAutor> _autores = [];

  DTOCategoria? _categoriaSelecionada;
  DTOAutor? _autorSelecionado;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _carregarDadosExtras();
      _loadEditData();
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _modoPreparoController.dispose();
    super.dispose();
  }

  Future<void> _carregarDadosExtras() async {
    try {
      final categorias = await _daoCategoria.buscarTodos();
      final autores = await _daoAutor.buscarTodos();
      setState(() {
        _categorias = categorias;
        _autores = autores;
      });
    } catch (_) {
      setState(() {
        _errorLoading = true;
      });
    }
  }

  void _loadEditData() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is DTOReceita) {
      _id = args.id;
      _nomeController.text = args.nome;
      _modoPreparoController.text = args.modoPreparo;

      final categoria = _categorias.firstWhere(
        (c) => c.id == args.categoriaId,
        orElse: () => DTOCategoria(id: 0, nome: 'Categoria inválida'),
      );
      _categoriaSelecionada = categoria.id == 0 ? null : categoria;

      final autor = _autores.firstWhere(
        (a) => a.id == args.autorId,
        orElse: () => DTOAutor(id: 0, nome: 'Autor inválido', email: ''),
      );
      _autorSelecionado = autor.id == 0 ? null : autor;

      setState(() => _errorLoading = false);
    }
  }

  DTOReceita _createDTO() {
    return DTOReceita(
      id: _id,
      nome: _nomeController.text,
      modoPreparo: _modoPreparoController.text,
      categoriaId: _categoriaSelecionada!.id!,
      autorId: _autorSelecionado!.id!,
    );
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      if (_categoriaSelecionada == null || _autorSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione uma categoria e um autor')),
        );
        return;
      }

      try {
        final dto = _createDTO();
        await _daoReceita.salvar(dto);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_id == null ? 'Receita criada!' : 'Receita atualizada!')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar receita: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro ao carregar receita')),
        body: const Center(child: Text('Não foi possível carregar os dados.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_id == null ? 'Nova Receita' : 'Editar Receita'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
            tooltip: 'Salvar',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CampoTexto(
                controle: _nomeController,
                rotulo: 'Nome',
                dica: 'Nome da receita',
                eObrigatorio: true,
              ),
              const SizedBox(height: 16),
              CampoDropdown<DTOCategoria>(
                rotulo: 'Categoria',
                valorSelecionado: _categoriaSelecionada,
                listaItens: _categorias,
                campoTextoItem: (item) => item.nome,
                aoSelecionar: (val) => setState(() => _categoriaSelecionada = val),
                eObrigatorio: true,
              ),
              const SizedBox(height: 16),
              CampoDropdown<DTOAutor>(
                rotulo: 'Autor',
                valorSelecionado: _autorSelecionado,
                listaItens: _autores,
                campoTextoItem: (item) => item.nome,
                aoSelecionar: (val) => setState(() => _autorSelecionado = val),
                eObrigatorio: true,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controle: _modoPreparoController,
                rotulo: 'Modo de preparo',
                dica: 'Descreva o modo de preparo',
                eObrigatorio: true,
                maxLinhas: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
