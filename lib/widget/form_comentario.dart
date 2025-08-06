import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/banco/sqlite/dao/comentario_dao.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/dto/dto_receita.dart';
import 'package:receita/dto/dto_comentario.dart';
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';
import 'package:receita/widget/componentes/campos/comum/campo_dropdown.dart';

class FormComentario extends StatefulWidget {
  final DTOComentario? comentario;

  const FormComentario({super.key, this.comentario});

  @override
  State<FormComentario> createState() => _FormComentarioState();
}

class _FormComentarioState extends State<FormComentario> {
  final _formKey = GlobalKey<FormState>();
  final _textoControlador = TextEditingController();
  final _notaControlador = TextEditingController();

  final DAOComentario _dao = DAOComentario();
  final DAOReceita _daoReceita = DAOReceita();
  final DAOAutor _daoAutor = DAOAutor();

  List<DTOReceita> _receitas = [];
  List<DTOAutor> _autores = [];

  DTOReceita? _receitaSelecionada;
  DTOAutor? _autorSelecionado;
  int? _id;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    final receitas = await _daoReceita.buscarTodos();
    final autores = await _daoAutor.buscarTodos();

    setState(() {
      _receitas = receitas;
      _autores = autores;

      if (widget.comentario != null) {
        final comentario = widget.comentario!;
        _id = comentario.id;
        _textoControlador.text = comentario.texto;
        _notaControlador.text = comentario.nota.toString();

        if (receitas.any((r) => r.id == comentario.receitaId)) {
          _receitaSelecionada = receitas.firstWhere((r) => r.id == comentario.receitaId);
        } else {
          _receitaSelecionada = receitas.isNotEmpty ? receitas.first : null;
        }

        if (autores.any((a) => a.id == comentario.autorId)) {
          _autorSelecionado = autores.firstWhere((a) => a.id == comentario.autorId);
        } else {
          _autorSelecionado = autores.isNotEmpty ? autores.first : null;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_id == null ? 'Novo Comentário' : 'Editar Comentário'),
      ),
      body: _receitas.isEmpty || _autores.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    CampoTexto(
                      controle: _textoControlador,
                      rotulo: 'Comentário',
                      dica: 'Digite o comentário',
                      eObrigatorio: true,
                      maxLinhas: 3,
                    ),
                    const SizedBox(height: 16),
                    CampoTexto(
                      controle: _notaControlador,
                      rotulo: 'Nota',
                      dica: 'Digite uma nota de 0 a 10',
                      tipoTeclado: TextInputType.number,
                      eObrigatorio: true,
                    ),
                    const SizedBox(height: 16),
                    CampoDropdown<DTOReceita>(
                      rotulo: 'Receita',
                      valorSelecionado: _receitaSelecionada,
                      listaItens: _receitas,
                      campoTextoItem: (r) => r.nome,
                      aoSelecionar: (r) => setState(() => _receitaSelecionada = r),
                      eObrigatorio: true,
                    ),
                    const SizedBox(height: 16),
                    CampoDropdown<DTOAutor>(
                      rotulo: 'Autor',
                      valorSelecionado: _autorSelecionado,
                      listaItens: _autores,
                      campoTextoItem: (a) => a.nome,
                      aoSelecionar: (a) => setState(() => _autorSelecionado = a),
                      eObrigatorio: true,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _salvar,
                        child: const Text('Salvar'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final novoComentario = DTOComentario(
        id: _id,
        texto: _textoControlador.text.trim(),
        nota: int.parse(_notaControlador.text),
        receitaId: _receitaSelecionada!.id!,
        autorId: _autorSelecionado!.id!,
      );

      if (_id == null) {
        await _dao.inserir(novoComentario);
      } else {
        await _dao.atualizar(novoComentario);
      }

      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao salvar comentário')),
        );
      }
    }
  }
}
