import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_categoria.dart';
import 'package:receita/banco/sqlite/dao/categoria_dao.dart';
import 'package:receita/widget/componentes/campos/comum/botao_icone.dart';
import 'package:receita/widget/componentes/campos/comum/titulo_lista.dart';

class ListaCategoria extends StatefulWidget {
  const ListaCategoria({super.key});

  @override
  State<ListaCategoria> createState() => _ListaCategoriaState();
}

class _ListaCategoriaState extends State<ListaCategoria> {
  final _dao = DAOCategoria();
  List<DTOCategoria> _lista = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);
    _lista = await _dao.buscarTodos();
    setState(() => _carregando = false);
  }

  Future<void> _excluir(DTOCategoria dto) async {
    if (dto.id == null) {
      throw Exception('ID da categoria é nulo e não pode ser excluído.');
    }
    await _dao.excluir(dto.id!);
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TituloLista(titulo: 'Categorias')),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _lista.isEmpty
              ? const Center(child: Text('Nenhuma categoria encontrada'))
              : ListView.builder(
                  itemCount: _lista.length,
                  itemBuilder: (context, index) {
                    final dto = _lista[index];
                    return Card(
                      child: ListTile(
                        title: Text(dto.nome),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            BotaoIcone(
                              icone: Icons.edit,
                              tooltip: 'Editar',
                              aoPressionar: () => Navigator.pushNamed(
                                context,
                                Rotas.cadastroCategoria,
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
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroCategoria)
            .then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
