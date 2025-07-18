import 'dto.dart';

class DTOUtensilio implements DTO {
  @override
  final int? id;
  @override
  final String nome;
  final String? material;
  final String? observacao;

  DTOUtensilio({
    this.id,
    required this.nome,
    this.material,
    this.observacao,
  });
}
