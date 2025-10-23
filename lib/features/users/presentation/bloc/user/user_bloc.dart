import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/create_user_usecase.dart';
import '../../../domain/usecases/get_user_by_id_usecase.dart';
import '../../../domain/usecases/get_users_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsersUseCase getUsersUseCase;
  final GetUserByIdUseCase getUserByIdUseCase;
  final CreateUserUseCase createUserUseCase;

  UserBloc({
    required this.getUsersUseCase,
    required this.getUserByIdUseCase,
    required this.createUserUseCase,
  }) : super(const UserInitial()) {
    on<LoadUsersEvent>(_onLoadUsers);
    on<LoadUserByIdEvent>(_onLoadUserById);
    on<CreateUserEvent>(_onCreateUser);
  }

  Future<void> _onLoadUsers(
    LoadUsersEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await getUsersUseCase();

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (users) => emit(UsersLoaded(users)),
    );
  }

  /// Maneja el evento de cargar un usuario por ID
  Future<void> _onLoadUserById(
    LoadUserByIdEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await getUserByIdUseCase(event.userId);

    result.fold(
      (failure) => emit(UserError(failure.message)),
      (user) => emit(UserLoaded(user)),
    );
  }

  /// Maneja el evento de crear usuario
  Future<void> _onCreateUser(
    CreateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());

    final result = await createUserUseCase(event.user);

    result.fold((failure) => emit(UserError(failure.message)), (user) {
      emit(const UserOperationSuccess('Usuario creado exitosamente'));
      // Recargar la lista de usuarios
      add(const LoadUsersEvent());
    });
  }
}
