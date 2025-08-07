import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_autor_receita_favorita.dart';
import 'package:receita/banco/sqlite/dao/autor_receita_favorita_dao.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/widget/componentes/campos/comum/botao_icone.dart';
import 'package:receita/widget/componentes/campos/comum/titulo_lista.dart';

class ListaAutorReceitaFavorita extends StatefulWidget {
  const ListaAutorReceitaFavorita({super.key});

  @override
  State<ListaAutorReceitaFavorita> createState() =>
      _ListaAutorReceitaFavoritaState();
}

class _ListaAutorReceitaFavoritaState
    extends State<ListaAutorReceitaFavorita> {
  final _dao = DAOAutorReceitaFavorita();
  final _daoAutor = DAOAutor();
  final _daoReceita = DAOReceita();

  List<DTOAutorReceitaFavorita> _lista = [];
  Map<int, String> _nomesAutores = {};
  Map<int, String> _nomesReceitas = {};
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);

    _lista = await _dao.buscarTodos();
    final autores = await _daoAutor.buscarTodos();
    final receitas = await _daoReceita.buscarTodos();

    _nomesAutores = {for (var a in autores) a.id!: a.nome};
    _nomesReceitas = {for (var r in receitas) r.id!: r.nome};

    setState(() => _carregando = false);
  }

  Future<void> _excluir(DTOAutorReceitaFavorita dto) async {
    if (dto.id == null) {
      throw Exception('ID da associação é nulo e não pode ser excluído.');
    }
    await _dao.excluirPorId(dto.id!);
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const TituloLista(titulo: 'Receitas Favoritas por Autor')),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _lista.isEmpty
              ? const Center(child: Text('Nenhuma receita favorita cadastrada'))
              : ListView.builder(
                  itemCount: _lista.length,
                  itemBuilder: (context, index) {
                    final dto = _lista[index];
                    final nomeAutor =
                        _nomesAutores[dto.autorId] ?? 'Autor desconhecido';
                    final nomeReceita =
                        _nomesReceitas[dto.receitaId] ?? 'Receita desconhecida';

                    return Card(
                      child: ListTile(
                        title: Text(nomeReceita),
                        subtitle: Text('Autor: $nomeAutor'),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            BotaoIcone(
                              icone: Icons.edit,
                              tooltip: 'Editar',
                              aoPressionar: () => Navigator.pushNamed(
                                context,
                                Rotas.cadastroAutorReceitaFavorita,
                                arguments: dto,
                              ).then((_) => _carregar()),
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          Rotas.cadastroAutorReceitaFavorita,
        ).then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
