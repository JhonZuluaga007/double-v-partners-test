part of 'users_list_bloc.dart';

@freezed
class UsersListEvent with _$UsersListEvent {
  const factory UsersListEvent.load() = _Load;
  const factory UsersListEvent.refresh() = _Refresh;
}
