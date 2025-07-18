import 'package:flutter/material.dart';

class CampoTelefone extends StatelessWidget {
  final TextEditingController controle;
  final String rotulo;
  final bool eObrigatorio;
  final Function(String)? aoAlterar;

  const CampoTelefone({
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
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (eObrigatorio && (value == null || value.isEmpty)) {
          return 'Preencha o campo $rotulo';
        }
        return null;
      },
      onChanged: aoAlterar,
    );
  }
}