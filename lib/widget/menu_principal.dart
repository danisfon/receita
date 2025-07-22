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

          const Divider(height: 32),
          const Text('Cadastrar Novo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _botao(context, 'Nova Categoria', Rotas.cadastroCategoria),
          _botao(context, 'Novo Autor', Rotas.cadastroAutor),
          _botao(context, 'Nova Dica', Rotas.cadastroDica),
          _botao(context, 'Novo Ingrediente', Rotas.cadastroIngrediente),
          _botao(context, 'Novo Utensílio', Rotas.cadastroUtensilio),
          _botao(context, 'Nova Receita', Rotas.cadastroReceita),
          _botao(context, 'Nova Associação Receita-Ingrediente', Rotas.cadastroReceitaIngrediente),
          _botao(context, 'Nova Rede Social do Autor', Rotas.cadastroAutorRedeSocial),
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
