import 'package:flutter/material.dart';

class CampoEmail extends StatelessWidget {
  final TextEditingController controle;
  final String rotulo;
  final bool eObrigatorio;
  final Function(String)? aoAlterar;

  const CampoEmail({
    super.key,
    required this.controle,
    required this.rotulo,
    this.eObrigatorio = false,
    this.aoAlterar,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controle,
      decoration: InputDecoration(
        labelText: rotulo,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (eObrigatorio && (value == null || value.isEmpty)) {
          return 'Preencha o campo $rotulo';
        }
        if (value != null && !value.contains('@')) {
          return 'Informe um e-mail válido';
        }
        return null;
      },
      onChanged: aoAlterar,
    );
  }
}