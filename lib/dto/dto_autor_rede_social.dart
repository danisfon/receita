import 'dto.dart';

class DTOAutorRedeSocial implements DTO {
  @override
  final int? id;

  final int autorId;
  final String rede;
  final String url;

  DTOAutorRedeSocial({
    this.id,
    required this.autorId,
    required this.rede,
    required this.url,
  });

  @override
  String get nome => rede; // Implementação do getter exigido
}
