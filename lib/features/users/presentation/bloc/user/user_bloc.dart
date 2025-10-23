import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/create_user_usecase.dart';
import '../../../domain/usecases/get_users_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

/// Bloc para manejar el estado de usuarios
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;
  final CreateUserUseCase createUserUseCase;

  UserBloc({required this.getUsersUseCase, required this.createUserUseCase})
    : super(const UserInitial()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<CreateUserEvent>(_onCreateUser);
  }

  /// Maneja el evento de cargar usuarios
  Future<void> _onLoadUsers(
    LoadUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await getUsersUseCase();

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (users) => emit(UserLoaded(users)),
    );
  }

  /// Maneja el evento de crear usuario
  Future<void> _onCreateUser(
    CreateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await createUserUseCase(
      name: event.name,
      email: event.email,
    );

    result.fold((failure) => emit(UserError(failure.message)), (user) {
      emit(const UserOperationSuccess('Usuario creado exitosamente'));
      // Recargar la lista de usuarios
      add(const LoadUsersEvent());
    });
  }
}
