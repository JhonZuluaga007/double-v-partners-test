import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/create_user_usecase.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';
part 'create_user_bloc.freezed.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  final CreateUserUseCase createUserUseCase;

  CreateUserBloc({required this.createUserUseCase})
    : super(const CreateUserState.initial()) {
    on<_Submit>(_onSubmit);
    on<_Reset>(_onReset);
  }

  Future<void> _onSubmit(_Submit event, Emitter<CreateUserState> emit) async {
    emit(const CreateUserState.submitting());

    final result = await createUserUseCase(event.user);

    result.fold(
      (failure) {
        debugPrint('❌ CreateUserBloc Error: ${failure.message}');
        emit(CreateUserState.error(failure.message));
      },
      (user) {
        debugPrint('✅ CreateUserBloc Success: ${user.fullName}');
        emit(CreateUserState.success(user));
      },
    );
  }

  void _onReset(_Reset event, Emitter<CreateUserState> emit) {
    emit(const CreateUserState.initial());
  }
}
