import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';
import 'package:receita/widget/componentes/campos/comum/campo_email.dart';
import 'package:receita/configuracao/rotas.dart';

class FormAutor extends StatefulWidget {
  const FormAutor({super.key});

  @override
  State<FormAutor> createState() => _FormAutorState();
}

class _FormAutorState extends State<FormAutor> {
  final _formKey = GlobalKey<FormState>();
  final _dao = DAOAutor();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  int? _id;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is DTOAutor) {
      _id = args.id;
      _nomeController.text = args.nome;
      _emailController.text = args.email;
      _bioController.text = args.bio ?? '';
    }
  }

  DTOAutor _criarDTO() {
    return DTOAutor(
      id: _id,
      nome: _nomeController.text,
      email: _emailController.text,
      bio: _bioController.text.isEmpty ? null : _bioController.text,
    );
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _dao.salvar(_criarDTO());
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, Rotas.listaAutores);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: \$e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_id != null ? 'Editar Autor' : 'Novo Autor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CampoTexto(
                controle: _nomeController,
                rotulo: 'Nome do Autor',
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoEmail(
                controle: _emailController,
                rotulo: 'E-mail',
                eObrigatorio: true,
              ),
              const SizedBox(height: 12),
              CampoTexto(
                controle: _bioController,
                rotulo: 'Biografia (opcional)',
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
