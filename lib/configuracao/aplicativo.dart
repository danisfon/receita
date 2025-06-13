import 'package:flutter/material.dart';
import '../widget/widget_receita.dart';
import '../widget/widget_listar_receita.dart';
import '../widget/widget_menu.dart';
import '../widget/widget_cadastrar_tag.dart';
import '/configuracao/rotas.dart';

//C:\Users\Aluno\Downloads\teste\flutter_application_1\lib\widget\componentes\widget.menu.dart

class Aplicativo extends StatelessWidget {
  const Aplicativo({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aula Widget',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      initialRoute: Rotas.home,
      routes: {
        //Rotas.home: (context) => WidgetMenu(),
        Rotas.home: (context) => WidgetMenu(),
        Rotas.receita: (context) => CadastrarReceita(),
        Rotas.listarReceita: (context) => ListaReceitas(),
        Rotas.cadastrarTag: (context) => CadastrarTag(),
      },
    );
  }
}
