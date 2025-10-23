import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

/// Eventos del UserBloc
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para cargar la lista de usuarios
class LoadUsersEvent extends UserEvent {
  const LoadUsersEvent();
}

/// Evento para cargar un usuario específico por ID
class LoadUserByIdEvent extends UserEvent {
  final String userId;

  const LoadUserByIdEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class CreateUserEvent extends UserEvent {
  final UserEntity user;

  const CreateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

/// Evento para actualizar un usuario existente
class UpdateUserEvent extends UserEvent {
  final UserEntity user;

  const UpdateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

/// Evento para eliminar un usuario
class DeleteUserEvent extends UserEvent {
  final String userId;

  const DeleteUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
