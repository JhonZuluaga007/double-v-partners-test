import '../models/user_model.dart';

/// Interfaz del data source local de usuarios
abstract class UserLocalDataSource {
  Future<List<UserModel>> getCachedUsers();
  Future<void> cacheUsers(List<UserModel> users);
  Future<void> clearCache();
}

/// Implementación del data source local de usuarios
class UserLocalDataSourceImpl implements UserLocalDataSource {
  // Aquí normalmente se inyectaría SharedPreferences, Hive, etc.
  // Para este ejemplo, usaremos una lista en memoria

  List<UserModel> _cachedUsers = [];

  @override
  Future<List<UserModel>> getCachedUsers() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _cachedUsers;
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cachedUsers = users;
  }

  @override
  Future<void> clearCache() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _cachedUsers = [];
  }
}
