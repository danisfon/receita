import 'package:flutter/material.dart';
import 'package:receita/banco/sqlite/dao/autor_dao.dart';
import 'package:receita/dto/dto_autor.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/widget/componentes/campos/comum/botao_icone.dart';
import 'package:receita/widget/componentes/campos/comum/titulo_lista.dart';

class ListaAutor extends StatefulWidget {
  const ListaAutor({super.key});

  @override
  State<ListaAutor> createState() => _ListaAutorState();
}

class _ListaAutorState extends State<ListaAutor> {
  final DAOAutor _dao = DAOAutor();
  List<DTOAutor> _itens = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TituloLista(titulo: 'Autores'),
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _itens.isEmpty
              ? const Center(child: Text('Nenhum autor cadastrado'))
              : ListView.builder(
                  itemCount: _itens.length,
                  itemBuilder: (context, index) => _itemLista(_itens[index]),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroAutor)
            .then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _itemLista(DTOAutor dto) {
    return ListTile(
      title: Text(dto.nome),
      subtitle: Text(dto.email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
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
      onTap: () => Navigator.pushNamed(
        context,
        Rotas.cadastroAutor,
        arguments: dto,
      ).then((_) => _carregar()),
    );
  }

  Future<void> _carregar() async {
    setState(() => _carregando = true);
    _itens = await _dao.buscarTodos();
    setState(() => _carregando = false);
  }

  Future<void> _excluir(DTOAutor dto) async {
    await _dao.excluir(dto.id!);
    _carregar();
  }
}
