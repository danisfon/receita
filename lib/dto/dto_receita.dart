class DTOReceita {
  final int? id;
  final String nome;
  final String ingredientes; 
  final String tags; 

  DTOReceita({
    this.id,
    required this.nome,
    required this.ingredientes,
    required this.tags,
  });
}
