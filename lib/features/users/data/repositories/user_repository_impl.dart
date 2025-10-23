import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_api_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiDataSource apiDataSource;

  UserRepositoryImpl({required this.apiDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final users = await apiDataSource.getUsers();
      return Right(users);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Error del servidor'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de conexión'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(String id) async {
    try {
      final user = await apiDataSource.getUserById(id);
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
  Future<Either<Failure, UserEntity>> createUser(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final createdUser = await apiDataSource.createUser(userModel);
      return Right(createdUser);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Error del servidor'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de conexión'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final updatedUser = await apiDataSource.updateUser(userModel);
      return Right(updatedUser);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Error del servidor'));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de conexión'));
    } catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser(String id) async {
    try {
      final result = await apiDataSource.deleteUser(id);
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
