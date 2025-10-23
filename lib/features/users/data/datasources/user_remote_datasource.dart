import '../models/user_model.dart';

/// Interfaz del data source remoto de usuarios
abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUserById(int id);
  Future<UserModel> createUser({required String name, required String email});
  Future<UserModel> updateUser({
    required int id,
    required String name,
    required String email,
  });
  Future<bool> deleteUser(int id);
}

/// Implementación del data source remoto de usuarios
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  // Aquí normalmente se inyectaría un cliente HTTP (Dio, http, etc.)
  // Para este ejemplo, simularemos las respuestas

  @override
  Future<List<UserModel>> getUsers() async {
    // Simulación de llamada API
    await Future.delayed(const Duration(seconds: 1));

    // Datos de ejemplo
    return [
      const UserModel(id: 1, name: 'Juan Pérez', email: 'juan@example.com'),
      const UserModel(id: 2, name: 'María García', email: 'maria@example.com'),
      const UserModel(id: 3, name: 'Carlos López', email: 'carlos@example.com'),
    ];
  }

  @override
  Future<UserModel> getUserById(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const UserModel(
      id: 1,
      name: 'Juan Pérez',
      email: 'juan@example.com',
    );
  }

  @override
  Future<UserModel> createUser({
    required String name,
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      email: email,
    );
  }

  @override
  Future<UserModel> updateUser({
    required int id,
    required String name,
    required String email,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return UserModel(id: id, name: name, email: email);
  }

  @override
  Future<bool> deleteUser(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
