import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Principal')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Listagens', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _botao(context, 'Categorias', Rotas.listaCategorias),
          _botao(context, 'Autores', Rotas.listaAutores),
          _botao(context, 'Dicas Culinárias', Rotas.listaDicas),
          _botao(context, 'Ingredientes', Rotas.listaIngredientes),
          _botao(context, 'Utensílios', Rotas.listaUtensilios),
          _botao(context, 'Receitas', Rotas.listaReceitas),
          _botao(context, 'Ingredientes por Receita', Rotas.listaReceitaIngredientes),
          _botao(context, 'Redes Sociais de Autores', Rotas.listaAutorRedeSocial),
          _botao(context, 'Receita favorita do Autores', Rotas.listaAutorReceitaFavorita),

          const Divider(height: 32),
          const Text('Cadastrar Novo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _botao(context, 'Cadastrar Categoria', Rotas.cadastroCategoria),
          _botao(context, 'Cadastrar Autor', Rotas.cadastroAutor),
          _botao(context, 'Cadastrar Dica', Rotas.cadastroDica),
          _botao(context, 'Cadastrar Ingrediente', Rotas.cadastroIngrediente),
          _botao(context, 'Cadastrar Utensílio', Rotas.cadastroUtensilio),
          _botao(context, 'Cadastrar Receita', Rotas.cadastroReceita),
          _botao(context, 'Cadastrar Ingredientes por Receita', Rotas.cadastroReceitaIngrediente),
          _botao(context, 'Cadastrar Rede Social do Autor', Rotas.cadastroAutorRedeSocial),
          _botao(context, 'Cadastrar Receita favorita do Autor', Rotas.cadastroAutorReceitaFavorita),
        ],
      ),
    );
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
}
