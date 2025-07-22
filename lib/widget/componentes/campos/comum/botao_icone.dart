import 'package:flutter/material.dart';

class BotaoIcone extends StatelessWidget {
  final IconData icone;
  final String tooltip;
  final VoidCallback aoPressionar;
  final Color? cor;

  const BotaoIcone({
    super.key,
    required this.icone,
    required this.tooltip,
    required this.aoPressionar,
    this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icone, color: cor ?? Theme.of(context).iconTheme.color),
      tooltip: tooltip,
      onPressed: aoPressionar,
    );
  }
}
