import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, UserEntity>> getUserById(String id);
  Future<Either<Failure, UserEntity>> createUser(UserEntity user);
  Future<Either<Failure, UserEntity>> updateUser(UserEntity user);
  Future<Either<Failure, bool>> deleteUser(String id);
}
