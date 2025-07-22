import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/autor_rede_social_dao.dart';
import 'package:receita/dto/dto_autor_rede_social.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';  
import 'package:receita/dto/dto_autor.dart';  
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';
import 'package:receita/widget/componentes/campos/comum/campo_dropdown.dart';

class FormAutorRedeSocial extends StatefulWidget {
  const FormAutorRedeSocial({super.key});

  @override
  State<FormAutorRedeSocial> createState() => _FormAutorRedeSocialState();
}

class _FormAutorRedeSocialState extends State<FormAutorRedeSocial> {
  final _formKey = GlobalKey<FormState>();
  final _daoRedeSocial = DAOAutorRedeSocial();
  final _daoAutor = DAOAutor();

  int? _id;
  DTOAutor? _autorSelecionado;
  final TextEditingController _redeController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  List<DTOAutor> _autores = [];
  bool _dadosCarregados = false;
  bool _erroCarregamento = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _carregarAutores();
      _carregarDadosEdicao();
    });
  }

  @override
  void dispose() {
    _redeController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _carregarAutores() async {
    try {
      final autores = await _daoAutor.buscarTodos();
      setState(() {
        _autores = autores;
        _dadosCarregados = true;
        _erroCarregamento = false;
      });
    } catch (_) {
      setState(() {
        _erroCarregamento = true;
      });
    }
  }

  void _carregarDadosEdicao() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is DTOAutorRedeSocial) {
      _id = args.id;
      _redeController.text = args.rede;
      _urlController.text = args.url;
            _autorSelecionado = _autores.isNotEmpty
          ? _autores.firstWhere(
              (a) => a.id == args.autorId,
              orElse: () => _autores.first,
            )
          : null;
      setState(() {});
    }
  }

  DTOAutorRedeSocial _criarDTO() {
    return DTOAutorRedeSocial(
      id: _id,
      autorId: _autorSelecionado!.id!,
      rede: _redeController.text.trim(),
      url: _urlController.text.trim(),
    );
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      if (_autorSelecionado == null) {
        _mostrarMensagem('Selecione um autor.', erro: true);
        return;
      }
      try {
        final dto = _criarDTO();
        await _daoRedeSocial.salvar(dto);
        if (!mounted) return;
        _mostrarMensagem(_id == null ? 'Rede social cadastrada!' : 'Rede social atualizada!');
        Navigator.of(context).pop();
      } catch (e) {
        _mostrarMensagem('Erro ao salvar: $e', erro: true);
      }
    }
  }

  void _mostrarMensagem(String mensagem, {bool erro = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: erro ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_erroCarregamento) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: const Center(child: Text('Erro ao carregar os dados')),
      );
    }

    if (!_dadosCarregados) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_id == null ? 'Nova Rede Social do Autor' : 'Editar Rede Social do Autor'),
        actions: [
          IconButton(
            onPressed: _salvar,
            icon: const Icon(Icons.save),
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
                controle: _redeController,
                rotulo: 'Rede Social',
                dica: 'Ex: Instagram, Twitter',
                eObrigatorio: true,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controle: _urlController,
                rotulo: 'URL',
                dica: 'Ex: https://instagram.com/usuario',
                eObrigatorio: true,
                tipoTeclado: TextInputType.url,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
