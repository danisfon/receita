import 'package:flutter/material.dart';
import '/configuracao/rotas.dart';
import 'widget_listar_receita.dart';

class WidgetMenu extends StatelessWidget {
  const WidgetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Widget criarMenu(
        {required IconData icone,
        required String rotulo,
        required String rota}) {
      return ListTile(
        leading: Icon(icone),
        title: Text(rotulo),
        onTap: () => Navigator.pushNamed(context, rota),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 180, 75, 230)),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            criarMenu(
                icone: Icons.add_box_outlined,
                rotulo: 'Cadastrar Receita',
                rota: Rotas.receita),
            criarMenu(
                icone: Icons.assignment_rounded,
                rotulo: 'Listar Receita',
                rota: Rotas.listarReceita),
            criarMenu(
                icone: Icons.label_outline,
                rotulo: 'Cadastrar Tag',
                rota: Rotas.cadastrarTag),
          ],
        ),
      ),
      body: ListaReceitas(),
    );
  }
}
