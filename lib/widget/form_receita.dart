import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/banco/sqlite/dao/categoria_dao.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_receita.dart';
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
  final _chaveFormulario = GlobalKey<FormState>();
  final _daoReceita = DAOReceita();
  final _daoCategoria = DAOCategoria();
  final _daoAutor = DAOAutor();

  final _nomeController = TextEditingController();
  final _modoPreparoController = TextEditingController();

  List<DTOCategoria> _categorias = [];
  List<DTOAutor> _autores = [];

  DTOCategoria? _categoriaSelecionada;
  DTOAutor? _autorSelecionado;
  int? _id;

  bool _carregandoDados = true;
  bool _erroAoCarregar = false;

  @override
  void initState() {
    super.initState();
    _carregarDadosIniciais();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _modoPreparoController.dispose();
    super.dispose();
  }

  Future<void> _carregarDadosIniciais() async {
    try {
      final categorias = await _daoCategoria.buscarTodos();
      final autores = await _daoAutor.buscarTodos();

      setState(() {
        _categorias = categorias;
        _autores = autores;
        _carregandoDados = false;
      });

      _carregarDadosEdicao();
    } catch (e) {
      setState(() {
        _erroAoCarregar = true;
        _carregandoDados = false;
      });
    }
  }

  void _carregarDadosEdicao() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is DTOReceita) {
      _id = args.id;
      _nomeController.text = args.nome;
      _modoPreparoController.text = args.modoPreparo;
      _categoriaSelecionada = _categorias.firstWhere(
        (c) => c.id == args.categoriaId,
        orElse: () => _categorias.first,
      );

      _autorSelecionado = _autores.firstWhere(
        (a) => a.id == args.autorId,
        orElse: () => _autores.first,
      );
    }
  }

  DTOReceita _criarDTO() {
    return DTOReceita(
      id: _id,
      nome: _nomeController.text,
      modoPreparo: _modoPreparoController.text,
      categoriaId: _categoriaSelecionada!.id!,
      autorId: _autorSelecionado!.id!,
    );
  }

  Future<void> _salvar() async {
    if (_chaveFormulario.currentState!.validate()) {
      if (_categoriaSelecionada == null || _autorSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione uma categoria e um autor')),
        );
        return;
      }

      try {
        await _daoReceita.salvar(_criarDTO());
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, Rotas.listaReceitas);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregandoDados) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_erroAoCarregar) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(child: Text('Erro ao carregar dados.')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Receita')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _chaveFormulario,
          child: ListView(
            children: [
              CampoTexto(
                controle: _nomeController,
                rotulo: 'Nome da Receita',
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoDropdown<DTOCategoria>(
                rotulo: 'Categoria',
                valorSelecionado: _categoriaSelecionada,
                listaItens: _categorias,
                campoTextoItem: (item) => item.nome,
                aoSelecionar: (val) =>
                    setState(() => _categoriaSelecionada = val),
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoDropdown<DTOAutor>(
                rotulo: 'Autor',
                valorSelecionado: _autorSelecionado,
                listaItens: _autores,
                campoTextoItem: (item) => item.nome,
                aoSelecionar: (val) => setState(() => _autorSelecionado = val),
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoTexto(
                controle: _modoPreparoController,
                rotulo: 'Modo de Preparo',
                maxLinhas: 5,
                eObrigatorio: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
