import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:double_v_partners_test/core/error/failures.dart';
import 'package:double_v_partners_test/features/users/domain/entities/address_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/user_entity.dart';
import 'package:double_v_partners_test/features/users/domain/repositories/user_repository.dart';
import 'package:double_v_partners_test/features/users/domain/usecases/create_user_usecase.dart';

class MockUserRepository extends Mock implements UserRepository {}

class FakeUserEntity extends Fake implements UserEntity {}

void main() {
  late CreateUserUseCase useCase;
  late MockUserRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeUserEntity());
  });

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = CreateUserUseCase(mockRepository);
  });

  final tUser = UserEntity(
    name: 'John',
    lastName: 'Doe',
    birthDate: DateTime(1990, 1, 1),
    addresses: const [
      AddressEntity(
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      ),
    ],
  );

  final tCreatedUser = UserEntity(
    id: '1',
    name: 'John',
    lastName: 'Doe',
    birthDate: DateTime(1990, 1, 1),
    addresses: const [
      AddressEntity(
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      ),
    ],
    createdAt: DateTime(2023, 1, 1),
    updatedAt: DateTime(2023, 1, 2),
  );

  test(
    'should return created user when repository call is successful',
    () async {
      when(
        () => mockRepository.createUser(tUser),
      ).thenAnswer((_) async => Right(tCreatedUser));

      final result = await useCase(tUser);

      expect(result, Right(tCreatedUser));
      verify(() => mockRepository.createUser(tUser)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return ServerFailure when repository call fails', () async {
    const tFailure = ServerFailure('Creation failed');
    when(
      () => mockRepository.createUser(tUser),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase(tUser);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.createUser(tUser)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return NetworkFailure when network error occurs', () async {
    const tFailure = NetworkFailure('Network error');
    when(
      () => mockRepository.createUser(tUser),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase(tUser);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.createUser(tUser)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return GeneralFailure when unexpected error occurs', () async {
    const tFailure = GeneralFailure('Unexpected error');
    when(
      () => mockRepository.createUser(tUser),
    ).thenAnswer((_) async => const Left(tFailure));

    final result = await useCase(tUser);

    expect(result, const Left(tFailure));
    verify(() => mockRepository.createUser(tUser)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should call repository with different user data', () async {
    final differentUser = UserEntity(
      name: 'Jane',
      lastName: 'Smith',
      birthDate: DateTime(1995, 5, 15),
      addresses: const [],
    );
    when(
      () => mockRepository.createUser(differentUser),
    ).thenAnswer((_) async => Right(tCreatedUser));

    await useCase(differentUser);

    verify(() => mockRepository.createUser(differentUser)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should handle user with multiple addresses', () async {
    final tUserWithMultipleAddresses = UserEntity(
      name: 'Alice',
      lastName: 'Wonderland',
      birthDate: DateTime(1988, 11, 30),
      addresses: const [
        AddressEntity(
          country: 'USA',
          department: 'California',
          municipality: 'Los Angeles',
        ),
        AddressEntity(
          country: 'USA',
          department: 'New York',
          municipality: 'New York City',
        ),
      ],
    );

    when(
      () => mockRepository.createUser(tUserWithMultipleAddresses),
    ).thenAnswer((_) async => Right(tCreatedUser));

    final result = await useCase(tUserWithMultipleAddresses);

    expect(result, Right(tCreatedUser));
    verify(
      () => mockRepository.createUser(tUserWithMultipleAddresses),
    ).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
