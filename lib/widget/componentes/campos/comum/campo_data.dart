import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CampoData extends StatelessWidget {
  final String rotulo;
  final bool eObrigatorio;
  final DateTime? valor;
  final Function(DateTime) aoAlterar;

  const CampoData({
    super.key,
    required this.rotulo,
    required this.valor,
    required this.aoAlterar,
    this.eObrigatorio = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(
      text: valor != null ? DateFormat('dd/MM/yyyy').format(valor!) : '',
    );

    return GestureDetector(
      onTap: () async {
        final dataSelecionada = await showDatePicker(
          context: context,
          initialDate: valor ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (dataSelecionada != null) {
          aoAlterar(dataSelecionada);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: rotulo,
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (eObrigatorio && (value == null || value.isEmpty)) {
              return 'Selecione a data';
            }
            return null;
          },
        ),
      ),
    );
  }
}