import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/categoria_dao.dart';
import 'package:receita/dto/dto_categoria.dart';
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';
import 'package:receita/configuracao/rotas.dart';

class FormCategoria extends StatefulWidget {
  const FormCategoria({super.key});

  @override
  State<FormCategoria> createState() => _FormCategoriaState();
}

class _FormCategoriaState extends State<FormCategoria> {
  final _chaveFormulario = GlobalKey<FormState>();
  final _dao = DAOCategoria();
  final TextEditingController _nomeControlador = TextEditingController();
  final TextEditingController _descricaoControlador = TextEditingController();
  int? _id;

  @override
  void dispose() {
    _nomeControlador.dispose();
    _descricaoControlador.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is DTOCategoria) {
      _id = args.id;
      _nomeControlador.text = args.nome;
      _descricaoControlador.text = args.descricao ?? '';
    }
  }

  DTOCategoria _criarDTO() {
    return DTOCategoria(
      id: _id,
      nome: _nomeControlador.text,
      descricao: _descricaoControlador.text.isEmpty ? null : _descricaoControlador.text,
    );
  }

  Future<void> _salvar() async {
    if (_chaveFormulario.currentState!.validate()) {
      try {
        await _dao.salvar(_criarDTO());
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, Rotas.listaCategorias);
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
      appBar: AppBar(title: const Text('Cadastro de Categoria')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _chaveFormulario,
          child: Column(
            children: [
              CampoTexto(
                controle: _nomeControlador,
                rotulo: 'Nome da Categoria',
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoTexto(
                controle: _descricaoControlador,
                rotulo: 'Descrição',
                maxLinhas: 3,
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
