import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_users_usecase.dart';

part 'users_list_event.dart';
part 'users_list_state.dart';
part 'users_list_bloc.freezed.dart';

class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final GetUsersUseCase getUsersUseCase;

  UsersListBloc({required this.getUsersUseCase})
    : super(const UsersListState.initial()) {
    on<_Load>(_onLoad);
    on<_Refresh>(_onRefresh);
  }

  Future<void> _onLoad(_Load event, Emitter<UsersListState> emit) async {
    emit(const UsersListState.loading());

    final result = await getUsersUseCase();

    result.fold(
      (failure) => emit(UsersListState.error(failure.message)),
      (users) => emit(UsersListState.loaded(users)),
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter<UsersListState> emit) async {
    final result = await getUsersUseCase();

    result.fold(
      (failure) => emit(UsersListState.error(failure.message)),
      (users) => emit(UsersListState.loaded(users)),
    );
  }
}
