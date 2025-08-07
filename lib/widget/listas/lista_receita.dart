import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_receita.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/banco/sqlite/dao/categoria_dao.dart';
import 'package:receita/widget/componentes/campos/comum/botao_icone.dart';
import 'package:receita/widget/componentes/campos/comum/titulo_lista.dart';

class ListaReceita extends StatefulWidget {
  const ListaReceita({super.key});

  @override
  State<ListaReceita> createState() => _ListaReceitaState();
}

class _ListaReceitaState extends State<ListaReceita> {
  final _dao = DAOReceita();
  final _daoCategoria = DAOCategoria();

  List<DTOReceita> _lista = [];
  Map<int, String> _nomesCategorias = {};
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);

    _lista = await _dao.buscarTodos();
    final categorias = await _daoCategoria.buscarTodos();
    _nomesCategorias = {
      for (var c in categorias) c.id!: c.nome,
    };

    setState(() => _carregando = false);
  }

  Future<void> _excluir(DTOReceita dto) async {
    if (dto.id == null) {
      throw Exception('ID da receita é nulo e não pode ser excluído.');
    }
    await _dao.excluir(dto.id!);
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TituloLista(titulo: 'Receitas')),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _lista.isEmpty
              ? const Center(child: Text('Nenhuma receita cadastrada'))
              : ListView.builder(
                  itemCount: _lista.length,
                  itemBuilder: (context, index) {
                    final dto = _lista[index];
                    final nomeCategoria = _nomesCategorias[dto.categoriaId] ?? 'Sem categoria';

                    return Card(
                      child: ListTile(
                        title: Text(dto.nome),
                        subtitle: Text('Categoria: $nomeCategoria'),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            BotaoIcone(
                              icone: Icons.edit,
                              tooltip: 'Editar',
                              aoPressionar: () => Navigator.pushNamed(
                                context,
                                Rotas.cadastroReceita,
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
          Rotas.cadastroReceita,
        ).then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
