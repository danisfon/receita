import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/banco/sqlite/dao/autor_rede_social_dao.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_autor_rede_social.dart';
import 'package:receita/widget/componentes/campos/comum/botao_icone.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaAutorRedeSocial extends StatefulWidget {
  const ListaAutorRedeSocial({super.key});

  @override
  State<ListaAutorRedeSocial> createState() => _ListaAutorRedeSocialState();
}

class _ListaAutorRedeSocialState extends State<ListaAutorRedeSocial> {
  final _daoRedeSocial = DAOAutorRedeSocial();
  final _daoAutor = DAOAutor();

  List<DTOAutorRedeSocial> _lista = [];
  Map<int, DTOAutor> _autoresMap = {};
  bool _carregando = true;
  bool _erro = false;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    try {
      final redes = await _daoRedeSocial.buscarTodos();
      final autores = await _daoAutor.buscarTodos();
      final mapAutores = {for (var a in autores) a.id!: a};

      setState(() {
        _lista = redes;
        _autoresMap = mapAutores;
        _carregando = false;
        _erro = false;
      });
    } catch (_) {
      setState(() {
        _erro = true;
        _carregando = false;
      });
    }
  }

  Future<void> _excluir(DTOAutorRedeSocial dto) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Deseja excluir esta rede social?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Excluir')),
        ],
      ),
    );

    if (confirmado == true) {
      await _daoRedeSocial.excluirPorId(dto.id!);
      _carregarDados();
    }
  }

  void _navegarParaEdicao(DTOAutorRedeSocial dto) {
    Navigator.of(context)
        .pushNamed(Rotas.cadastroAutorRedeSocial, arguments: dto)
        .then((_) {
      _carregarDados();
    });
  }

  void _navegarParaCadastro() {
    Navigator.of(context).pushNamed(Rotas.cadastroAutorRedeSocial).then((_) {
      _carregarDados();
    });
  }

  Future<void> _abrirUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_erro) {
      return Scaffold(
        appBar: AppBar(title: const Text('Redes Sociais dos Autores')),
        body: const Center(child: Text('Erro ao carregar os dados')),
      );
    }

    if (_carregando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Redes Sociais dos Autores'),
        actions: [
          IconButton(
            onPressed: _navegarParaCadastro,
            icon: const Icon(Icons.add),
            tooltip: 'Nova Rede Social',
          ),
        ],
      ),
      body: _lista.isEmpty
          ? const Center(child: Text('Nenhuma rede social cadastrada.'))
          : ListView.builder(
              itemCount: _lista.length,
              itemBuilder: (_, index) {
                final dto = _lista[index];
                final autor = _autoresMap[dto.autorId];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(dto.rede),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Autor: ${autor?.nome ?? 'Desconhecido'}'),
                        Text(dto.url),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BotaoIcone(
                          icone: Icons.link,
                          tooltip: 'Abrir Rede Social',
                          aoPressionar: () => _abrirUrl(dto.url),
                        ),
                        const SizedBox(width: 8),
                        BotaoIcone(
                          icone: Icons.edit,
                          tooltip: 'Editar',
                          aoPressionar: () => _navegarParaEdicao(dto),
                        ),
                        const SizedBox(width: 8),
                        BotaoIcone(
                          icone: Icons.delete,
                          tooltip: 'Excluir',
                          aoPressionar: () => _excluir(dto),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
