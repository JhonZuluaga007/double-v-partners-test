import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

/// Implementación del repositorio de usuarios - capa de datos
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      // Intentar obtener datos remotos
      final users = await remoteDataSource.getUsers();

      // Cachear los datos
      await localDataSource.cacheUsers(users);

      return Right(users);
    } on ServerException catch (e) {
      // Si falla el servidor, intentar obtener datos del caché
      try {
        final cachedUsers = await localDataSource.getCachedUsers();
        if (cachedUsers.isNotEmpty) {
          return Right(cachedUsers);
        }
        return Left(ServerFailure(e.message ?? 'Error del servidor'));
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message ?? 'Error al cargar caché'));
      }
    } on NetworkException catch (e) {
      // Si hay error de red, intentar obtener del caché
      try {
        final cachedUsers = await localDataSource.getCachedUsers();
        if (cachedUsers.isNotEmpty) {
          return Right(cachedUsers);
        }
        return Left(NetworkFailure(e.message ?? 'Error de conexión'));
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message ?? 'Error al cargar caché'));
      }
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) async {
    try {
      final user = await remoteDataSource.getUserById(id);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Error del servidor'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de conexión'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createUser({
    required String name,
    required String email,
  }) async {
    try {
      final user = await remoteDataSource.createUser(name: name, email: email);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Error del servidor'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de conexión'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser({
    required int id,
    required String name,
    required String email,
  }) async {
    try {
      final user = await remoteDataSource.updateUser(
        id: id,
        name: name,
        email: email,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Error del servidor'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de conexión'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(int id) async {
    try {
      final result = await remoteDataSource.deleteUser(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Error del servidor'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de conexión'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
