// lib/receita_app.dart
import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';
import 'package:receita/widget/menu_principal.dart';

// IMPORTS DOS FORMULÁRIOS
import 'package:receita/widget/form_categoria.dart';
import 'package:receita/widget/form_autor.dart';
import 'package:receita/widget/form_dica.dart';
import 'package:receita/widget/form_ingrediente.dart';
import 'package:receita/widget/form_utensilio.dart';
import 'package:receita/widget/form_receita.dart';
import 'package:receita/widget/form_receita_ingrediente.dart';
import 'package:receita/widget/form_autor_rede_social.dart';
import 'package:receita/widget/form_autor_receita_favorita.dart';
import 'package:receita/widget/form_comentario.dart';

// IMPORTS DAS LISTAS
import 'package:receita/widget/listas/lista_categoria.dart';
import 'package:receita/widget/listas/lista_autor.dart';
import 'package:receita/widget/listas/lista_dica.dart';
import 'package:receita/widget/listas/lista_ingrediente.dart';
import 'package:receita/widget/listas/lista_utensilio.dart';
import 'package:receita/widget/listas/lista_receita.dart';
import 'package:receita/widget/listas/lista_receita_ingrediente.dart';
import 'package:receita/widget/listas/lista_autor_rede_social.dart';
import 'package:receita/widget/listas/lista_autor_receita_favorita.dart';
import 'package:receita/widget/listas/lista_comentario.dart';
import 'package:receita/widget/listas/lista_receitas_por_categoria.dart';


class ReceitaApp extends StatelessWidget {
  const ReceitaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receita App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      initialRoute: Rotas.menuPrincipal,
      routes: {
        // FORMULÁRIOS
        Rotas.cadastroCategoria: (context) => const FormCategoria(),
        Rotas.cadastroAutor: (context) => const FormAutor(),
        Rotas.cadastroDica: (context) => const FormDica(),
        Rotas.cadastroIngrediente: (context) => const FormIngrediente(),
        Rotas.cadastroUtensilio: (context) => const FormUtensilio(),
        Rotas.cadastroReceita: (context) => const FormReceita(),
        Rotas.cadastroReceitaIngrediente: (context) => const FormReceitaIngrediente(),
        Rotas.cadastroAutorRedeSocial: (context) => const FormAutorRedeSocial(),
        Rotas.cadastroAutorReceitaFavorita: (context) => const FormAutorReceitaFavorita(),
        Rotas.cadastroComentario: (context) => const FormComentario(),


        // LISTAS
        Rotas.listaCategorias: (context) => const ListaCategoria(),
        Rotas.listaAutores: (context) => const ListaAutor(),
        Rotas.listaDicas: (context) => const ListaDica(),
        Rotas.listaIngredientes: (context) => const ListaIngrediente(),
        Rotas.listaUtensilios: (context) => const ListaUtensilio(),
        Rotas.listaReceitas: (context) => const ListaReceita(),
        Rotas.listaReceitaIngredientes: (context) => const ListaReceitaIngrediente(),
        Rotas.listaAutorRedeSocial: (context) => const ListaAutorRedeSocial(),
        Rotas.listaAutorReceitaFavorita: (context) => const ListaAutorReceitaFavorita(),
        Rotas.listaComentario: (context) => const ListaComentario(),

        Rotas.receitasPorCategoria: (context) {
          final argumentos = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          final int categoriaId = argumentos['categoriaId'];
          final String nomeCategoria = argumentos['nomeCategoria'];

          return ListaReceitasPorCategoria(
            categoriaId: categoriaId,
            nomeCategoria: nomeCategoria,
          );
        },

        Rotas.menuPrincipal: (context) => const MenuPrincipal(),
      },
    );
  }
}
