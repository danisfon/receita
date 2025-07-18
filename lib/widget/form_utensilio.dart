import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/utensilio_dao.dart';
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
  int? _id;
  bool _errorLoading = false;

  final TextEditingController _nomeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadEditData());
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _loadEditData() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is DTOUtensilio) {
      try {
        _id = args.id;
        _nomeController.text = args.nome;
        setState(() => _errorLoading = false);
      } catch (_) {
        setState(() => _errorLoading = true);
      }
    }
  }

  DTOUtensilio _createDTO() {
    return DTOUtensilio(
      id: _id,
      nome: _nomeController.text,
    );
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      try {
        final dto = _createDTO();
        await _dao.salvar(dto);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_id == null ? 'Utensílio criado!' : 'Utensílio atualizado!')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar utensílio: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_errorLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro ao carregar utensílio')),
        body: const Center(child: Text('Não foi possível carregar os dados.')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_id == null ? 'Novo Utensílio' : 'Editar Utensílio'),
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
          child: CampoTexto(
            controle: _nomeController,
            rotulo: 'Nome',
            dica: 'Nome do utensílio',
            eObrigatorio: true,
          ),
        ),
      ),
    );
  }
}
