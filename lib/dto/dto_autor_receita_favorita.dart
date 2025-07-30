import 'dto.dart';

class DTOAutorReceitaFavorita implements DTO {
  @override
  final int? id;

  final int autorId;
  final int receitaId;

  DTOAutorReceitaFavorita({
    this.id,
    required this.autorId,
    required this.receitaId,
  });

  @override
  String get nome => 'Autor $autorId - Receita $receitaId';
}
