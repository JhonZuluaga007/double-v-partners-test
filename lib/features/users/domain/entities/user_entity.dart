import 'package:equatable/equatable.dart';

/// Entidad de usuario - capa de dominio
/// Inmutable y sin dependencias externas
class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;

  const UserEntity({required this.id, required this.name, required this.email});

  @override
  List<Object?> get props => [id, name, email];

  @override
  String toString() => 'UserEntity(id: $id, name: $name, email: $email)';
}
