import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/utensilio_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_utensilio.dart';
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';

class FormUtensilio extends StatefulWidget {
  const FormUtensilio({super.key});

  @override
  State<FormUtensilio> createState() => _FormUtensilioState();
}

class _FormUtensilioState extends State<FormUtensilio> {
  final _formKey = GlobalKey<FormState>();
  final _dao = DAOUtensilio();
  final TextEditingController _nomeController = TextEditingController();

  int? _id;

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is DTOUtensilio) {
      _id = args.id;
      _nomeController.text = args.nome;
    }
  }

  DTOUtensilio _criarDTO() {
    return DTOUtensilio(
      id: _id,
      nome: _nomeController.text,
    );
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _dao.salvar(_criarDTO());
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, Rotas.listaUtensilios);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar utensílio: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_id == null ? 'Novo Utensílio' : 'Editar Utensílio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CampoTexto(
                controle: _nomeController,
                rotulo: 'Nome',
                dica: 'Nome do utensílio',
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
