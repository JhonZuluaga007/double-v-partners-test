import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:double_v_partners_test/core/error/failures.dart';
import 'package:double_v_partners_test/features/users/domain/entities/address_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/user_entity.dart';
import 'package:double_v_partners_test/features/users/domain/repositories/user_repository.dart';
import 'package:double_v_partners_test/features/users/domain/usecases/get_users_usecase.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late GetUsersUseCase useCase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUsersUseCase(mockRepository);
  });

  final tAddresses = [
    const AddressEntity(
      id: 'addr1',
      country: 'Colombia',
      department: 'Antioquia',
      municipality: 'Medellín',
    ),
    const AddressEntity(
      id: 'addr2',
      country: 'México',
      department: 'Jalisco',
      municipality: 'Guadalajara',
    ),
  ];

  final tUsers = [
    UserEntity(
      id: '1',
      name: 'John',
      lastName: 'Doe',
      birthDate: DateTime(1990, 1, 1),
      addresses: tAddresses,
      createdAt: DateTime(2023, 1, 1),
      updatedAt: DateTime(2023, 1, 2),
    ),
    UserEntity(
      id: '2',
      name: 'Jane',
      lastName: 'Smith',
      birthDate: DateTime(1995, 5, 15),
      addresses: tAddresses,
      createdAt: DateTime(2023, 1, 1),
      updatedAt: DateTime(2023, 1, 2),
    ),
  ];

  test('should return users when repository call is successful', () async {
    when(
      () => mockRepository.getUsers(),
    ).thenAnswer((_) async => Right(tUsers));

    final result = await useCase();

    expect(result, Right(tUsers));
    verify(() => mockRepository.getUsers()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return ServerFailure when repository call fails', () async {
    const tFailure = ServerFailure('Server error');
    when(
      () => mockRepository.getUsers(),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase();

    expect(result, const Left(tFailure));
    verify(() => mockRepository.getUsers()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return NetworkFailure when network error occurs', () async {
    const tFailure = NetworkFailure('Network error');
    when(
      () => mockRepository.getUsers(),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase();

    expect(result, const Left(tFailure));
    verify(() => mockRepository.getUsers()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return GeneralFailure when unexpected error occurs', () async {
    const tFailure = GeneralFailure('Unexpected error');
    when(
      () => mockRepository.getUsers(),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase();

    expect(result, const Left(tFailure));
    verify(() => mockRepository.getUsers()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return empty list when no users exist', () async {
    when(
      () => mockRepository.getUsers(),
    ).thenAnswer((_) async => const Right([]));

    final result = await useCase();

    expect(result, isA<Right<Failure, List<UserEntity>>>());
    result.fold((failure) => fail('should not return failure'), (users) {
      expect(users, isEmpty);
    });
    verify(() => mockRepository.getUsers()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
