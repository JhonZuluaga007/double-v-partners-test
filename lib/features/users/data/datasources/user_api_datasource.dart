import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class UserApiDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUserById(String id);
  Future<UserModel> createUser(UserModel user);
  Future<UserModel> updateUser(UserModel user);
  Future<bool> deleteUser(String id);
}

class UserApiDataSourceImpl implements UserApiDataSource {
  final ApiClient apiClient;

  UserApiDataSourceImpl({required this.apiClient});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await apiClient.dio.get('/users');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      throw ServerException(
        'Error al obtener usuarios: ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Tiempo de espera agotado');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Error de conexión');
      }
      throw ServerException(e.message ?? 'Error del servidor');
    } catch (e) {
      throw ServerException('Error inesperado: $e');
    }
  }

  @override
  Future<UserModel> getUserById(String id) async {
    try {
      final response = await apiClient.dio.get('/users/$id');

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      }

      throw ServerException('Error al obtener usuario: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Tiempo de espera agotado');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Error de conexión');
      }
      throw ServerException(e.message ?? 'Error del servidor');
    } catch (e) {
      throw ServerException('Error inesperado: $e');
    }
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    try {
      final response = await apiClient.dio.post('/users', data: user.toJson());

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      }

      throw ServerException('Error al crear usuario: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Tiempo de espera agotado');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Error de conexión');
      }
      throw ServerException(e.message ?? 'Error del servidor');
    } catch (e) {
      throw ServerException('Error inesperado: $e');
    }
  }

  @override
  Future<UserModel> updateUser(UserModel user) async {
    try {
      final response = await apiClient.dio.put(
        '/users/${user.id}',
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data as Map<String, dynamic>);
      }

      throw ServerException(
        'Error al actualizar usuario: ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Tiempo de espera agotado');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Error de conexión');
      }
      throw ServerException(e.message ?? 'Error del servidor');
    } catch (e) {
      throw ServerException('Error inesperado: $e');
    }
  }

  @override
  Future<bool> deleteUser(String id) async {
    try {
      final response = await apiClient.dio.delete('/users/$id');

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      }

      throw ServerException(
        'Error al eliminar usuario: ${response.statusCode}',
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Tiempo de espera agotado');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('Error de conexión');
      }
      throw ServerException(e.message ?? 'Error del servidor');
    } catch (e) {
      throw ServerException('Error inesperado: $e');
    }
  }
}
