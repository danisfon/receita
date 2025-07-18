import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controle;
  final String rotulo;
  final String? dica;
  final bool eObrigatorio;
  final int maxLinhas;
  final TextInputType tipoTeclado; // <-- Adicionado

  const CampoTexto({
    super.key,
    required this.controle,
    required this.rotulo,
    this.dica,
    this.eObrigatorio = false,
    this.maxLinhas = 1,
    this.tipoTeclado = TextInputType.text, // <-- Valor padrão
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controle,
      maxLines: maxLinhas,
      keyboardType: tipoTeclado, // <-- Aplicado aqui
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: dica,
        border: const OutlineInputBorder(),
      ),
      validator: (valor) {
        if (eObrigatorio && (valor == null || valor.isEmpty)) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }
}
