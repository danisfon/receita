import 'dto.dart';

class DTOIngrediente implements DTO {
  @override
  final int? id;
  @override
  final String nome;
  final String? tipo;
  final double? quantidadePadrao;
  final String? unidade;

  DTOIngrediente({
    this.id,
    required this.nome,
    this.tipo,
    this.quantidadePadrao,
    this.unidade,
  });
}
