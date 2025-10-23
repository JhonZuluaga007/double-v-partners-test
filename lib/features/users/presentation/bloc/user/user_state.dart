import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

/// Estados del Bloc de usuarios
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial
class UserInitial extends UserState {
  const UserInitial();
}

/// Estado de carga
class UserLoading extends UserState {
  const UserLoading();
}

/// Estado de éxito al cargar usuarios
class UserLoaded extends UserState {
  final List<UserEntity> users;

  const UserLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

/// Estado de éxito al crear/actualizar/eliminar usuario
class UserOperationSuccess extends UserState {
  final String message;

  const UserOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Estado de error
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
