import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

/// Estados del UserBloc
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

/// Estado de lista de usuarios cargada
class UsersLoaded extends UserState {
  final List<UserEntity> users;

  const UsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

/// Estado de usuario único cargado
class UserLoaded extends UserState {
  final UserEntity user;

  const UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

/// Estado de operación exitosa (crear/actualizar/eliminar)
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
