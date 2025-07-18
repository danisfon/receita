import 'dto.dart';

class DTODica implements DTO {
  @override
  final int? id;
  @override
  final String nome; 
  final String descricao;

  DTODica({
    this.id,
    required this.nome,
    required this.descricao,
  });
}
