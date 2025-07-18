import 'dto.dart';

class DTOReceita implements DTO {
  @override
  final int? id;
  @override
  final String nome;
  final String modoPreparo;
  final int? tempoPreparo; // em minutos
  final int categoriaId;
  final int autorId;

  DTOReceita({
    this.id,
    required this.nome,
    required this.modoPreparo,
    this.tempoPreparo,
    required this.categoriaId,
    required this.autorId,
  });
}
