part of 'user_detail_bloc.dart';

@freezed
class UserDetailEvent with _$UserDetailEvent {
  const factory UserDetailEvent.load(String userId) = _Load;
  const factory UserDetailEvent.refresh() = _Refresh;
}
