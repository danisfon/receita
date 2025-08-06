class DTOComentario {
  int? id;
  int receitaId;
  int autorId;
  String texto;
  int nota;

  DTOComentario({
    this.id,
    required this.receitaId,
    required this.autorId,
    required this.texto,
    required this.nota,
  });

  factory DTOComentario.fromMap(Map<String, dynamic> map) {
    return DTOComentario(
      id: map['id'],
      receitaId: map['receita_id'],
      autorId: map['autor_id'],
      texto: map['texto'],
      nota: map['nota'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'receita_id': receitaId,
      'autor_id': autorId,
      'texto': texto,
      'nota': nota,
    };
  }
}
