part of 'create_user_bloc.dart';

@freezed
class CreateUserEvent with _$CreateUserEvent {
  const factory CreateUserEvent.submit(UserEntity user) = _Submit;
  const factory CreateUserEvent.reset() = _Reset;
}
