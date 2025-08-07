import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_utensilio.dart';
import 'package:receita/banco/sqlite/dao/utensilio_dao.dart';
import 'package:receita/widget/componentes/campos/comum/botao_icone.dart';
import 'package:receita/widget/componentes/campos/comum/titulo_lista.dart';

class ListaUtensilio extends StatefulWidget {
  const ListaUtensilio({super.key});

  @override
  State<ListaUtensilio> createState() => _ListaUtensilioState();
}

class _ListaUtensilioState extends State<ListaUtensilio> {
  final _dao = DAOUtensilio();
  List<DTOUtensilio> _lista = [];
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

  Future<void> _excluir(DTOUtensilio dto) async {
    if (dto.id == null) {
      throw Exception('ID do utensílio é nulo e não pode ser excluído.');
    }
    await _dao.excluir(dto.id!);
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TituloLista(titulo: 'Utensílios')),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _lista.isEmpty
              ? const Center(child: Text('Nenhum utensílio encontrado'))
              : ListView.builder(
                  itemCount: _lista.length,
                  itemBuilder: (context, index) {
                    final dto = _lista[index];
                    return Card(
                      child: ListTile(
                        title: Text(dto.nome),
                        subtitle: Text(dto.material ?? ''),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            BotaoIcone(
                              icone: Icons.edit,
                              tooltip: 'Editar',
                              aoPressionar: () => Navigator.pushNamed(
                                context,
                                Rotas.cadastroUtensilio,
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
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroUtensilio)
            .then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
