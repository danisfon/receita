import 'dto.dart';

class DTOAutor implements DTO {
  @override
  final int? id;
  @override
  final String nome;
  final String email;
  final String? bio;

  DTOAutor({
    this.id,
    required this.nome,
    required this.email,
    this.bio,
  });
}
