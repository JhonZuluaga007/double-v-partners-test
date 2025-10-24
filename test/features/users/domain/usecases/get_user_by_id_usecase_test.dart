import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:double_v_partners_test/core/error/failures.dart';
import 'package:double_v_partners_test/features/users/domain/entities/address_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/user_entity.dart';
import 'package:double_v_partners_test/features/users/domain/repositories/user_repository.dart';
import 'package:double_v_partners_test/features/users/domain/usecases/get_user_by_id_usecase.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late GetUserByIdUseCase useCase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUserByIdUseCase(mockRepository);
  });

  const tUserId = '1';
  final tUser = UserEntity(
    id: '1',
    name: 'John',
    lastName: 'Doe',
    birthDate: DateTime(1990, 1, 1),
    addresses: const [
      AddressEntity(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      ),
    ],
    createdAt: DateTime(2023, 1, 1),
    updatedAt: DateTime(2023, 1, 2),
  );

  test('should return user when repository call is successful', () async {
    when(
      () => mockRepository.getUserById(tUserId),
    ).thenAnswer((_) async => Right(tUser));

    final result = await useCase(tUserId);

    expect(result, Right(tUser));
    verify(() => mockRepository.getUserById(tUserId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ServerFailure when repository call fails', () async {
    const tFailure = ServerFailure('User not found');
    when(
      () => mockRepository.getUserById(tUserId),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase(tUserId);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.getUserById(tUserId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return NetworkFailure when network error occurs', () async {
    const tFailure = NetworkFailure('Network error');
    when(
      () => mockRepository.getUserById(tUserId),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase(tUserId);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.getUserById(tUserId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return GeneralFailure when unexpected error occurs', () async {
    const tFailure = GeneralFailure('Unexpected error');
    when(
      () => mockRepository.getUserById(tUserId),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase(tUserId);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.getUserById(tUserId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should call repository with correct user ID', () async {
    const differentUserId = '2';
    when(
      () => mockRepository.getUserById(differentUserId),
    ).thenAnswer((_) async => Right(tUser));

    await useCase(differentUserId);

    verify(() => mockRepository.getUserById(differentUserId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
