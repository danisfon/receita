import 'dto.dart';

class DTOCategoria implements DTO {
  @override
  final int? id;
  @override
  final String nome;
  final String? descricao;

  DTOCategoria({
    this.id,
    required this.nome,
    this.descricao,
  });
}
