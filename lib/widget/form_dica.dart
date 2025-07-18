import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/dica_dao.dart';
import 'package:receita/dto/dto_dica.dart';
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';
import 'package:receita/configuracao/rotas.dart';

class FormDica extends StatefulWidget {
  const FormDica({super.key});

  @override
  State<FormDica> createState() => _FormDicaState();
}

class _FormDicaState extends State<FormDica> {
  final _chaveFormulario = GlobalKey<FormState>();
  final _dao = DAODica();
  final _nomeControlador = TextEditingController();
  final _descricaoControlador = TextEditingController();
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
    if (args != null && args is DTODica) {
      _id = args.id;
      _nomeControlador.text = args.nome;
      _descricaoControlador.text = args.descricao;
    }
  }

  DTODica _criarDTO() {
    return DTODica(
      id: _id,
      nome: _nomeControlador.text,
      descricao: _descricaoControlador.text,
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
