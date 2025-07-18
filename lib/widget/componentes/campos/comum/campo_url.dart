import 'package:flutter/material.dart';

class CampoUrl extends StatelessWidget {
  final String rotulo;
  final String? dica;
  final String? valorInicial;
  final bool eObrigatorio;
  final Widget? prefixoIcone;
  final Function(String)? aoAlterar;

  const CampoUrl({
    super.key,
    required this.rotulo,
    this.dica,
    this.valorInicial,
    this.eObrigatorio = false,
    this.prefixoIcone,
    this.aoAlterar,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: valorInicial ?? '');
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: rotulo,
        hintText: dica,
        border: const OutlineInputBorder(),
        prefixIcon: prefixoIcone,
      ),
      keyboardType: TextInputType.url,
      validator: (value) {
        if (eObrigatorio && (value == null || value.isEmpty)) {
          return 'Informe o campo $rotulo';
        }
        return null;
      },
      onChanged: aoAlterar,
    );
  }
}
