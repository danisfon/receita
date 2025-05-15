import 'package:flutter/material.dart';

class Receita {
  final String nome;
  final List<String> ingredientes;

  Receita({required this.nome, required this.ingredientes});
}

class ListaReceitas extends StatelessWidget {
  final List<Receita> receitasMock = [
    Receita(
      nome: 'Bolo de Cenoura',
      ingredientes: [
        '5 Cenoura',
        '1/2 xicara de farinha de trigo',
        '2 xicaras de açúcar',
        '3 Ovos',
        'Óleo'
      ],
    ),
    Receita(
      nome: 'Macarronada',
      ingredientes: [
        '500g de macarrão',
        'Molho de tomate (a gosto)',
        '1kg de Carne moída',
        '1 cebola picada'
      ],
    ),
    Receita(
      nome: 'Salada de Frutas',
      ingredientes: ['Maçã', 'Banana', 'Laranja', 'Uva', 'Manga'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receitas Cadastradas'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: receitasMock.length,
        itemBuilder: (context, index) {
          final receita = receitasMock[index];
          return Card(
            child: ExpansionTile(
              title: Text(
                receita.nome,
              ),
              children: receita.ingredientes
                  .map(
                    (ingrediente) => ListTile(
                      title: Text(ingrediente),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
