import 'package:equatable/equatable.dart';

/// Eventos del Bloc de usuarios
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar la lista de usuarios
class LoadUsersEvent extends UserEvent {
  const LoadUsersEvent();
}

/// Evento para crear un nuevo usuario
class CreateUserEvent extends UserEvent {
  final String name;
  final String email;

  const CreateUserEvent({required this.name, required this.email});

  @override
  List<Object?> get props => [name, email];
}

/// Evento para actualizar un usuario
class UpdateUserEvent extends UserEvent {
  final int id;
  final String name;
  final String email;

  const UpdateUserEvent({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email];
}

/// Evento para eliminar un usuario
class DeleteUserEvent extends UserEvent {
  final int id;

  const DeleteUserEvent(this.id);

  @override
  List<Object?> get props => [id];
}
