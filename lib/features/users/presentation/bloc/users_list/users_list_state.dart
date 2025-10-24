part of 'users_list_bloc.dart';

@freezed
class UsersListState with _$UsersListState {
  const factory UsersListState.initial() = _Initial;
  const factory UsersListState.loading() = _Loading;
  const factory UsersListState.loaded(List<UserEntity> users) = _Loaded;
  const factory UsersListState.error(String message) = _Error;
}
