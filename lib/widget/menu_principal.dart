import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/banco/sqlite/dao/categoria_dao.dart';
import 'package:receita/dto/dto_categoria.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menu Principal'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Listagens'),
              Tab(text: 'Cadastros'),
              Tab(text: 'Receitas'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _AbaListagens(),
            _AbaCadastros(),
            _AbaReceitasPorCategoria(),
          ],
        ),
      ),
    );
  }
}

class _AbaListagens extends StatelessWidget {
  const _AbaListagens();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Listagens',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _botao(context, 'Categorias', Rotas.listaCategorias),
        _botao(context, 'Autores', Rotas.listaAutores),
        _botao(context, 'Dicas Culinárias', Rotas.listaDicas),
        _botao(context, 'Ingredientes', Rotas.listaIngredientes),
        _botao(context, 'Utensílios', Rotas.listaUtensilios),
        _botao(context, 'Receitas', Rotas.listaReceitas),
        _botao(context, 'Ingredientes por Receita', Rotas.listaReceitaIngredientes),
        _botao(context, 'Redes Sociais de Autores', Rotas.listaAutorRedeSocial),
        _botao(context, 'Receita favorita dos Autores', Rotas.listaAutorReceitaFavorita),
        _botao(context, 'Avaliações das receitas', Rotas.listaComentario),
      ],
    );
  }
}

class _AbaCadastros extends StatelessWidget {
  const _AbaCadastros();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Cadastros',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _botao(context, 'Cadastrar Categoria', Rotas.cadastroCategoria),
        _botao(context, 'Cadastrar Autor', Rotas.cadastroAutor),
        _botao(context, 'Cadastrar Dica', Rotas.cadastroDica),
        _botao(context, 'Cadastrar Ingrediente', Rotas.cadastroIngrediente),
        _botao(context, 'Cadastrar Utensílio', Rotas.cadastroUtensilio),
        _botao(context, 'Cadastrar Receita', Rotas.cadastroReceita),
        _botao(context, 'Cadastrar Ingredientes por Receita', Rotas.cadastroReceitaIngrediente),
        _botao(context, 'Cadastrar Rede Social do Autor', Rotas.cadastroAutorRedeSocial),
        _botao(context, 'Cadastrar Receita Favorita do Autor', Rotas.cadastroAutorReceitaFavorita),
        _botao(context, 'Cadastrar Avaliação de receita', Rotas.cadastroComentario),
      ],
    );
  }
}

class _AbaReceitasPorCategoria extends StatefulWidget {
  const _AbaReceitasPorCategoria();

  @override
  State<_AbaReceitasPorCategoria> createState() => _AbaReceitasPorCategoriaState();
}

class _AbaReceitasPorCategoriaState extends State<_AbaReceitasPorCategoria> {
  final DAOCategoria _daoCategoria = DAOCategoria();
  List<DTOCategoria> _categorias = [];

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
  }

  Future<void> _carregarCategorias() async {
    final categorias = await _daoCategoria.buscarTodos();
    setState(() {
      _categorias = categorias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _categorias.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Receitas por Categoria',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._categorias.map((categoria) => _botaoCategoria(context, categoria)).toList(),
            ],
          );
  }

  Widget _botaoCategoria(BuildContext context, DTOCategoria categoria) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            Rotas.receitasPorCategoria,
            arguments: {
              'categoriaId': categoria.id,
              'nomeCategoria': categoria.nome,
            },
          );
        },
        child: Text(categoria.nome),
      ),
    );
  }
}

Widget _botao(BuildContext context, String titulo, String rota) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, rota),
      child: Text(titulo),
    ),
  );
}
