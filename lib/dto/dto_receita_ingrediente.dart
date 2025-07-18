import 'dto.dart';

class DTOReceitaIngrediente implements DTO {
  @override
  final int? id;

  final int receitaId;
  final int ingredienteId;
  final double? quantidade;
  final String? unidade;

  final String? nomeReceita;
  final String? nomeIngrediente;

  DTOReceitaIngrediente({
    this.id,
    required this.receitaId,
    required this.ingredienteId,
    this.quantidade,
    this.unidade,
    this.nomeReceita,
    this.nomeIngrediente,
  });

  @override
  String get nome => nomeReceita ?? '';

  factory DTOReceitaIngrediente.fromMap(Map<String, dynamic> map) {
    return DTOReceitaIngrediente(
      id: map['id'] as int?,
      receitaId: map['receita_id'] as int,
      ingredienteId: map['ingrediente_id'] as int,
      quantidade: (map['quantidade'] as num?)?.toDouble(),
      unidade: map['unidade'] as String?,
      nomeReceita: map['nome_receita'] as String?,
      nomeIngrediente: map['nome_ingrediente'] as String?,
    );
  }
}
