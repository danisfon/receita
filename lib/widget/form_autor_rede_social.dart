import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/banco/sqlite/dao/autor_rede_social_dao.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/dto/dto_autor_rede_social.dart';
import 'package:receita/widget/componentes/campos/comum/campo_texto.dart';

class FormAutorRedeSocial extends StatefulWidget {
  const FormAutorRedeSocial({super.key});

  @override
  State<FormAutorRedeSocial> createState() => _FormAutorRedeSocialState();
}

class _FormAutorRedeSocialState extends State<FormAutorRedeSocial> {
  final _chaveFormulario = GlobalKey<FormState>();
  final _dao = DAOAutorRedeSocial();
  final _daoAutor = DAOAutor();
  final TextEditingController _redeControlador = TextEditingController();
  final TextEditingController _urlControlador = TextEditingController();

  List<DTOAutor> _autores = [];
  DTOAutor? _autorSelecionado;
  DTOAutorRedeSocial? _dtoRecebido;
  int? _id;
  bool _carregando = true;
  bool _erro = false;

  @override
  void dispose() {
    _redeControlador.dispose();
    _urlControlador.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is DTOAutorRedeSocial) {
      _dtoRecebido = args;
      _id = args.id;
      _redeControlador.text = args.rede;
      _urlControlador.text = args.url;
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarAutores();
  }

  Future<void> _carregarAutores() async {
    try {
      final lista = await _daoAutor.buscarTodos();
      setState(() {
        _autores = lista;
        _erro = false;
        if (_dtoRecebido != null) {
          _autorSelecionado = lista.firstWhere(
            (a) => a.id == _dtoRecebido!.autorId,
            orElse: () => _autores.isNotEmpty ? _autores.first : DTOAutor(id: 0, nome: '', email: ''),
          );
        }
      });
    } catch (_) {
      setState(() {
        _erro = true;
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  DTOAutorRedeSocial _criarDTO() {
    return DTOAutorRedeSocial(
      id: _id,
      autorId: _autorSelecionado!.id!,
      rede: _redeControlador.text,
      url: _urlControlador.text,
    );
  }

  Future<void> _salvar() async {
    if (_chaveFormulario.currentState!.validate()) {
      try {
        await _dao.salvar(_criarDTO());
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, Rotas.listaAutorRedeSocial);
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
      appBar: AppBar(
        title: Text(_id == null ? 'Nova Rede Social' : 'Editar Rede Social'),
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _erro
              ? const Center(child: Text('Erro ao carregar autores.'))
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _chaveFormulario,
                    child: Column(
                      children: [
                        DropdownButtonFormField<DTOAutor>(
                          value: _autorSelecionado,
                          items: _autores
                              .map((autor) => DropdownMenuItem(
                                    value: autor,
                                    child: Text(autor.nome),
                                  ))
                              .toList(),
                          onChanged: (valor) {
                            setState(() {
                              _autorSelecionado = valor;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Autor',
                            border: OutlineInputBorder(),
                          ),
                          validator: (valor) => valor == null ? 'Selecione um autor' : null,
                        ),
                        const SizedBox(height: 12),
                        CampoTexto(
                          controle: _redeControlador,
                          rotulo: 'Rede Social',
                          eObrigatorio: true,
                        ),
                        const SizedBox(height: 12),
                        CampoTexto(
                          controle: _urlControlador,
                          rotulo: 'URL',
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
