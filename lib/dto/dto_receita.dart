class DTOReceita {
  int? id;
  String nome;
  List<String> ingredientes;
  List<String> tags;

  DTOReceita({
    this.id,
    required this.nome,
    required this.ingredientes,
    required this.tags,
  });
}
