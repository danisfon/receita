import 'package:flutter/material.dart';

class CampoDropdown<T> extends StatelessWidget {
  final String rotulo;
  final T? valorSelecionado;
  final List<T> listaItens;
  final String Function(T item) campoTextoItem;
  final void Function(T?)? aoSelecionar;
  final bool eObrigatorio;

  const CampoDropdown({
    super.key,
    required this.rotulo,
    required this.valorSelecionado,
    required this.listaItens,
    required this.campoTextoItem,
    required this.aoSelecionar,
    this.eObrigatorio = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: valorSelecionado,
      items: listaItens.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(campoTextoItem(item)),
        );
      }).toList(),
      onChanged: aoSelecionar,
      decoration: InputDecoration(
        labelText: rotulo,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (eObrigatorio && value == null) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }
}
