import 'package:flutter/material.dart';

class CadastrarTag extends StatefulWidget {
  final Function(String)?
      onNovaTag; // Agora opcional, já que não será usada via parâmetro na navegação

  const CadastrarTag({super.key, this.onNovaTag});

  @override
  State<CadastrarTag> createState() => _CadastrarTagState();
}

class _CadastrarTagState extends State<CadastrarTag> {
  final TextEditingController _controller = TextEditingController();

  void _salvarTag() {
    if (_controller.text.trim().isNotEmpty) {
      // Se o callback existir, chama
      widget.onNovaTag?.call(_controller.text.trim());

      // Fecha a tela
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar TAG')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Nome da TAG'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _salvarTag,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
