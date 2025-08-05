import 'dto.dart';

class DTODica implements DTO {
  @override
  final int? id;
  final String titulo;
  final String descricao;
  final int autorId;

  DTODica({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.autorId,
  });

  @override
  String get nome => titulo;
}
