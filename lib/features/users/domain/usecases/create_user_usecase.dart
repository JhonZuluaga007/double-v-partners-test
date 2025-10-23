import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Caso de uso para crear un nuevo usuario
class CreateUserUseCase {
  final UserRepository repository;

  CreateUserUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String name,
    required String email,
  }) async {
    return await repository.createUser(name: name, email: email);
  }
}
