import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';

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
        _botao(context, 'Ingredientes por Receita',
            Rotas.listaReceitaIngredientes),
        _botao(context, 'Redes Sociais de Autores', Rotas.listaAutorRedeSocial),
        _botao(context, 'Receita favorita dos Autores',
            Rotas.listaAutorReceitaFavorita),
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
        _botao(context, 'Cadastrar Ingredientes por Receita',
            Rotas.cadastroReceitaIngrediente),
        _botao(context, 'Cadastrar Rede Social do Autor',
            Rotas.cadastroAutorRedeSocial),
        _botao(context, 'Cadastrar Receita Favorita do Autor',
            Rotas.cadastroAutorReceitaFavorita),
      ],
    );
  }
}

class _AbaReceitasPorCategoria extends StatelessWidget {
  const _AbaReceitasPorCategoria();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Receitas por Categoria',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        _botaoCategoria(context, 'Sobremesa'),
        _botaoCategoria(context, 'Prato Principal'),
        _botaoCategoria(context, 'Entrada'),
        _botaoCategoria(context, 'Lanche'),
        _botaoCategoria(context, 'Bebida'),
      ],
    );
  }

  Widget _botaoCategoria(BuildContext context, String categoria) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            Rotas.receitasPorCategoria,
            arguments: categoria,
          );
        },
        child: Text(categoria),
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
