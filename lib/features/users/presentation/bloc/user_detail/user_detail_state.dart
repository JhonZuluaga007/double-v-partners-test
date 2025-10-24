part of 'user_detail_bloc.dart';

@freezed
class UserDetailState with _$UserDetailState {
  const factory UserDetailState.initial() = _Initial;
  const factory UserDetailState.loading() = _Loading;
  const factory UserDetailState.loaded(UserEntity user) = _Loaded;
  const factory UserDetailState.error(String message) = _Error;
}
