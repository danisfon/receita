import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/banco/sqlite/dao/dica_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/dto/dto_dica.dart';
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';
import 'package:receita/widget/componentes/campos/comum/campo_dropdown.dart';

class FormDica extends StatefulWidget {
  const FormDica({super.key});

  @override
  State<FormDica> createState() => _FormDicaState();
}

class _FormDicaState extends State<FormDica> {
  final _chaveFormulario = GlobalKey<FormState>();
  final _dao = DAODica();
  final _daoAutor = DAOAutor();

  final _nomeControlador = TextEditingController();
  final _descricaoControlador = TextEditingController();
  int? _id;
  DTOAutor? _autorSelecionado;
  List<DTOAutor> _autores = [];

  @override
  void dispose() {
    _nomeControlador.dispose();
    _descricaoControlador.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _carregarAutores();
  }

  Future<void> _carregarAutores() async {
    final autores = await _daoAutor.buscarTodos();

    final args = ModalRoute.of(context)?.settings.arguments;
    DTODica? dicaRecebida;
    if (args != null && args is DTODica) {
      dicaRecebida = args;
    }

    setState(() {
      _autores = autores;

      if (dicaRecebida != null) {
        _id = dicaRecebida.id;
        _nomeControlador.text = dicaRecebida.nome;
        _descricaoControlador.text = dicaRecebida.descricao;

        final autorCorrespondente = autores.where((a) => a.id == dicaRecebida!.autorId);
        _autorSelecionado = autorCorrespondente.isNotEmpty ? autorCorrespondente.first : null;
      }
    });

  }

  DTODica _criarDTO() {
    return DTODica(
      id: _id,
      titulo: _nomeControlador.text,
      descricao: _descricaoControlador.text,
      autorId: _autorSelecionado?.id ?? 0, // Certifique-se de validar antes
    );
  }

  Future<void> _salvar() async {
    if (_chaveFormulario.currentState!.validate()) {
      try {
        await _dao.salvar(_criarDTO());
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, Rotas.listaDicas);
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
    return Scaffold(
      appBar: AppBar(title: Text(_id != null ? 'Editar Dica' : 'Nova Dica')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _chaveFormulario,
          child: Column(
            children: [
              CampoTexto(
                controle: _nomeControlador,
                rotulo: 'Título da Dica',
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoTexto(
                controle: _descricaoControlador,
                rotulo: 'Descrição',
                maxLinhas: 3,
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoDropdown<DTOAutor>(
                listaItens: _autores,
                valorSelecionado: _autorSelecionado,
                campoTextoItem: (autor) => autor.nome,
                aoSelecionar: (autor) => setState(() => _autorSelecionado = autor),
                rotulo: 'Autor da Dica',
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
