import 'package:flutter/material.dart';

class TituloLista extends StatelessWidget {
  final String titulo;

  const TituloLista({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
