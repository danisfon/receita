import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/dto/dto_comentario.dart';
import 'package:receita/banco/sqlite/dao/comentario_dao.dart';
import 'package:receita/banco/sqlite/dao/receita_dao.dart';
import 'package:receita/widget/componentes/campos/comum/botao_icone.dart';
import 'package:receita/widget/componentes/campos/comum/titulo_lista.dart';

class ListaComentario extends StatefulWidget {
  const ListaComentario({super.key});

  @override
  State<ListaComentario> createState() => _ListaComentarioState();
}

class _ListaComentarioState extends State<ListaComentario> {
  final _dao = DAOComentario();
  final _daoReceita = DAOReceita();

  List<DTOComentario> _lista = [];
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

    final receitas = await _daoReceita.buscarTodos();
    _nomesReceitas = {for (var r in receitas) r.id!: r.nome};

    setState(() => _carregando = false);
  }

  Future<void> _excluir(DTOComentario dto) async {
    if (dto.id == null) {
      throw Exception('ID do comentário é nulo e não pode ser excluído.');
    }
    await _dao.excluir(dto.id!);
    _carregar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TituloLista(titulo: 'Comentários')),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _lista.isEmpty
              ? const Center(child: Text('Nenhum comentário encontrado'))
              : ListView.builder(
                  itemCount: _lista.length,
                  itemBuilder: (context, index) {
                    final dto = _lista[index];
                    final nomeReceita =
                        _nomesReceitas[dto.receitaId] ?? 'Receita desconhecida';
                    return Card(
                      child: ListTile(
                        title: Text(dto.texto),
                        subtitle: Text('Nota: ${dto.nota} • Receita: $nomeReceita'),
                        trailing: Wrap(
                          spacing: 8,
                          children: [
                            BotaoIcone(
                              icone: Icons.edit,
                              tooltip: 'Editar',
                              aoPressionar: () => Navigator.pushNamed(
                                context,
                                Rotas.cadastroComentario,
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
        onPressed: () => Navigator.pushNamed(context, Rotas.cadastroComentario)
            .then((_) => _carregar()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
