import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/receita_ingrediente_dao.dart';
import 'package:receita/dto/dto_receita_ingrediente.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/banco/sqlite/dao/ingrediente_dao.dart';
import 'package:receita/dto/dto_receita.dart';
import 'package:receita/dto/dto_ingrediente.dart';
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';
import 'package:receita/widget/componentes/campos/comum/campo_dropdown.dart';
import 'package:receita/configuracao/rotas.dart';

class FormReceitaIngrediente extends StatefulWidget {
  const FormReceitaIngrediente({super.key});

  @override
  State<FormReceitaIngrediente> createState() => _FormReceitaIngredienteState();
}

class _FormReceitaIngredienteState extends State<FormReceitaIngrediente> {
  final _formKey = GlobalKey<FormState>();
  final _dao = DAOReceitaIngrediente();
  final _daoReceita = DAOReceita();
  final _daoIngrediente = DAOIngrediente();

  int? _id;
  DTOReceita? _receitaSelecionada;
  DTOIngrediente? _ingredienteSelecionado;
  final TextEditingController _quantidadeController = TextEditingController();

  List<DTOReceita> _receitas = [];
  List<DTOIngrediente> _ingredientes = [];

  bool _dadosCarregados = false;
  bool _erroCarregamento = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _carregarListas();
      _carregarDadosEdicao();
    });
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }

  Future<void> _carregarListas() async {
    try {
      final receitas = await _daoReceita.buscarTodos();
      final ingredientes = await _daoIngrediente.buscarTodos();
      setState(() {
        _receitas = receitas;
        _ingredientes = ingredientes;
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
    if (args != null && args is DTOReceitaIngrediente) {
      _id = args.id;
      _quantidadeController.text = args.quantidade?.toString() ?? '';
      _receitaSelecionada = _receitas.firstWhere(
        (r) => r.id == args.receitaId,
        orElse: () => DTOReceita(id: 0, nome: 'Inválido', modoPreparo: '', categoriaId: 0, autorId: 0),
      );
      _ingredienteSelecionado = _ingredientes.firstWhere(
        (i) => i.id == args.ingredienteId,
        orElse: () => DTOIngrediente(id: 0, nome: 'Inválido'),
      );
    }
  }

  DTOReceitaIngrediente _criarDTO() {
    return DTOReceitaIngrediente(
      id: _id,
      receitaId: _receitaSelecionada!.id!,
      ingredienteId: _ingredienteSelecionado!.id!,
      quantidade: double.tryParse(_quantidadeController.text),
    );
  }

  Future<void> _salvar() async {
    if (_formKey.currentState!.validate()) {
      if (_receitaSelecionada == null || _ingredienteSelecionado == null) {
        _mostrarMensagem('Selecione a receita e o ingrediente.', erro: true);
        return;
      }
      try {
        await _dao.salvar(_criarDTO());
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, Rotas.listaReceitaIngredientes);
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
        title: Text(_id == null ? 'Nova Associação' : 'Editar Associação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CampoDropdown<DTOReceita>(
                rotulo: 'Receita',
                valorSelecionado: _receitaSelecionada,
                listaItens: _receitas,
                campoTextoItem: (item) => item.nome,
                aoSelecionar: (val) => setState(() => _receitaSelecionada = val),
                eObrigatorio: true,
              ),
              const SizedBox(height: 16),
              CampoDropdown<DTOIngrediente>(
                rotulo: 'Ingrediente',
                valorSelecionado: _ingredienteSelecionado,
                listaItens: _ingredientes,
                campoTextoItem: (item) => item.nome,
                aoSelecionar: (val) => setState(() => _ingredienteSelecionado = val),
                eObrigatorio: true,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controle: _quantidadeController,
                rotulo: 'Quantidade',
                dica: 'Ex: 2.5 (em números)',
                eObrigatorio: true,
                tipoTeclado: TextInputType.number,
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
