import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

/// Interfaz del repositorio de usuarios - capa de dominio
/// Define el contrato que debe implementar el repositorio en la capa de datos
abstract class UserRepository {
  /// Obtiene la lista de usuarios
  Future<Either<Failure, List<UserEntity>>> getUsers();

  /// Obtiene un usuario por su ID
  Future<Either<Failure, UserEntity>> getUserById(int id);

  /// Crea un nuevo usuario
  Future<Either<Failure, UserEntity>> createUser({
    required String name,
    required String email,
  });

  /// Actualiza un usuario existente
  Future<Either<Failure, UserEntity>> updateUser({
    required int id,
    required String name,
    required String email,
  });

  /// Elimina un usuario
  Future<Either<Failure, bool>> deleteUser(int id);
}
