// lib/receita_app.dart
import 'package:flutter/material.dart';
import 'package:receita/configuracao/rotas.dart';

// IMPORTS DOS FORMULÁRIOS
import 'package:receita/widget/form_categoria.dart';
import 'package:receita/widget/form_autor.dart';
import 'package:receita/widget/form_dica.dart';
import 'package:receita/widget/form_ingrediente.dart';
import 'package:receita/widget/form_utensilio.dart';
import 'package:receita/widget/form_receita.dart';
import 'package:receita/widget/form_receita_ingrediente.dart';

// IMPORTS DAS LISTAS
import 'package:receita/widget/listas/lista_categoria.dart';
import 'package:receita/widget/listas/lista_autor.dart';
import 'package:receita/widget/listas/lista_dica.dart';
import 'package:receita/widget/listas/lista_ingrediente.dart';
import 'package:receita/widget/listas/lista_utensilio.dart';
import 'package:receita/widget/listas/lista_receita.dart';
import 'package:receita/widget/listas/lista_receita_ingrediente.dart';

import 'package:receita/widget/menu_principal.dart';


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

        // LISTAS
        Rotas.listaCategorias: (context) => const ListaCategoria(),
        Rotas.listaAutores: (context) => const ListaAutor(),
        Rotas.listaDicas: (context) => const ListaDica(),
        Rotas.listaIngredientes: (context) => const ListaIngrediente(),
        Rotas.listaUtensilios: (context) => const ListaUtensilio(),
        Rotas.listaReceitas: (context) => const ListaReceita(),
        Rotas.listaReceitaIngredientes: (context) => const ListaReceitaIngrediente(),

        Rotas.menuPrincipal: (context) => const MenuPrincipal(),
      },
    );
  }
}
