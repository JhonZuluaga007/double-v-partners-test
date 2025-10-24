part of 'create_user_bloc.dart';

@freezed
class CreateUserState with _$CreateUserState {
  const factory CreateUserState.initial() = _Initial;
  const factory CreateUserState.submitting() = _Submitting;
  const factory CreateUserState.success(UserEntity user) = _Success;
  const factory CreateUserState.error(String message) = _Error;
}
