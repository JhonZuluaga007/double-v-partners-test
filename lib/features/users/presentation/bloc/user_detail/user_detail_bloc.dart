import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/get_user_by_id_usecase.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';
part 'user_detail_bloc.freezed.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final GetUserByIdUseCase getUserByIdUseCase;
  String? _currentUserId;

  UserDetailBloc({required this.getUserByIdUseCase})
    : super(const UserDetailState.initial()) {
    on<_Load>(_onLoad);
    on<_Refresh>(_onRefresh);
  }

  Future<void> _onLoad(_Load event, Emitter<UserDetailState> emit) async {
    _currentUserId = event.userId;
    emit(const UserDetailState.loading());

    final result = await getUserByIdUseCase(event.userId);

    result.fold(
      (failure) => emit(UserDetailState.error(failure.message)),
      (user) => emit(UserDetailState.loaded(user)),
    );
  }

  Future<void> _onRefresh(_Refresh event, Emitter<UserDetailState> emit) async {
    if (_currentUserId == null) return;

    emit(const UserDetailState.loading());

    final result = await getUserByIdUseCase(_currentUserId!);

    result.fold(
      (failure) => emit(UserDetailState.error(failure.message)),
      (user) => emit(UserDetailState.loaded(user)),
    );
  }
}
