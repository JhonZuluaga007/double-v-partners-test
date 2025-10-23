import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

/// Caso de uso para obtener un usuario por ID
class GetUserByIdUseCase {
  final UserRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String id) async {
    return await repository.getUserById(id);
  }
}
