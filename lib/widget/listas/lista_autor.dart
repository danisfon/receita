import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/widget/componentes/campos/comum/botao_icone.dart';
import 'package:receita/widget/componentes/campos/comum/titulo_lista.dart';

class ListaAutor extends StatefulWidget {
  const ListaAutor({super.key});

  @override
  State<ListaAutor> createState() => _ListaAutorState();
}

class _ListaAutorState extends State<ListaAutor> {
  final _dao = DAOAutor();
  List<DTOAutor> _lista = [];
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

  Future<void> _excluir(DTOAutor dto) async {
    if (dto.id == null) {
      throw Exception('ID do autor é nulo e não pode ser excluído.');
    }
    await _dao.excluir(dto.id!);
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TituloLista(titulo: 'Autores')),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _lista.isEmpty
              ? const Center(child: Text('Nenhum autor encontrado'))
              : ListView.builder(
                  itemCount: _lista.length,
                  itemBuilder: (context, index) {
                    final dto = _lista[index];
                    return Card(
                      child: ListTile(
                        title: Text(dto.nome),
                        subtitle: Text(dto.email),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            BotaoIcone(
                              icone: Icons.share,
                              tooltip: 'Redes sociais',
                              aoPressionar: () => Navigator.pushNamed(
                                context,
                                Rotas.listaAutorRedeSocial,
                                arguments: dto,
                              ),
                            ),
                            BotaoIcone(
                              icone: Icons.edit,
                              tooltip: 'Editar',
                              aoPressionar: () => Navigator.pushNamed(
                                context,
                                Rotas.cadastroAutor,
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
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroAutor)
            .then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
