import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:double_v_partners_test/core/error/exceptions.dart';
import 'package:double_v_partners_test/core/error/failures.dart';
import 'package:double_v_partners_test/features/users/data/datasources/user_api_datasource.dart';
import 'package:double_v_partners_test/features/users/data/models/address_model.dart';
import 'package:double_v_partners_test/features/users/data/models/user_model.dart';
import 'package:double_v_partners_test/features/users/data/repositories/user_repository_impl.dart';
import 'package:double_v_partners_test/features/users/domain/entities/address_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/user_entity.dart';
import 'package:double_v_partners_test/features/users/domain/repositories/user_repository.dart';

class MockUserApiDataSource extends Mock implements UserApiDataSource {}

class FakeUserEntity extends Fake implements UserEntity {}

class FakeUserModel extends Fake implements UserModel {}

void main() {
  late UserRepositoryImpl repository;
  late MockUserApiDataSource mockApiDataSource;

  setUpAll(() {
    registerFallbackValue(FakeUserEntity());
    registerFallbackValue(FakeUserModel());
  });

  setUp(() {
    mockApiDataSource = MockUserApiDataSource();
    repository = UserRepositoryImpl(apiDataSource: mockApiDataSource);
  });

  group('UserRepositoryImpl', () {
    group('getUsers', () {
      final tUsers = [
        UserModel(
          id: '1',
          name: 'John',
          lastName: 'Doe',
          birthDate: DateTime(1990, 1, 1),
          addresses: const [
            AddressModel(
              id: 'addr1',
              country: 'Colombia',
              department: 'Antioquia',
              municipality: 'Medellín',
            ),
          ],
        ),
      ];

      test('should return users when API call is successful', () async {
        when(
          () => mockApiDataSource.getUsers(),
        ).thenAnswer((_) async => tUsers);

        final result = await repository.getUsers();

        expect(result, isA<Right<Failure, List<UserEntity>>>());
        result.fold((failure) => fail('should not return failure'), (users) {
          expect(users.length, 1);
          expect(users.first.name, 'John');
        });
        verify(() => mockApiDataSource.getUsers()).called(1);
      });

      test('should return ServerFailure when API call fails', () async {
        when(
          () => mockApiDataSource.getUsers(),
        ).thenThrow(ServerException('Server error'));

        final result = await repository.getUsers();

        expect(result, isA<Left<Failure, List<UserEntity>>>());
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Server error');
        }, (users) => fail('should return failure'));
      });

      test('should return NetworkFailure when network error occurs', () async {
        when(
          () => mockApiDataSource.getUsers(),
        ).thenThrow(NetworkException('Network error'));

        final result = await repository.getUsers();

        expect(result, isA<Left<Failure, List<UserEntity>>>());
        result.fold((failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, 'Network error');
        }, (users) => fail('should return failure'));
      });

      test(
        'should return GeneralFailure when unexpected error occurs',
        () async {
          when(
            () => mockApiDataSource.getUsers(),
          ).thenThrow('Unexpected error');

          final result = await repository.getUsers();

          expect(result, isA<Left<Failure, List<UserEntity>>>());
          result.fold((failure) {
            expect(failure, isA<GeneralFailure>());
            expect(failure.message, 'Unexpected error');
          }, (users) => fail('should return failure'));
        },
      );
    });

    group('getUserById', () {
      const tUserId = '1';
      final tUser = UserModel(
        id: '1',
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: const [],
      );

      test('should return user when API call is successful', () async {
        when(
          () => mockApiDataSource.getUserById(tUserId),
        ).thenAnswer((_) async => tUser);

        final result = await repository.getUserById(tUserId);

        expect(result, isA<Right<Failure, UserEntity>>());
        result.fold((failure) => fail('should not return failure'), (user) {
          expect(user.id, '1');
          expect(user.name, 'John');
        });
        verify(() => mockApiDataSource.getUserById(tUserId)).called(1);
      });

      test('should return ServerFailure when API call fails', () async {
        when(
          () => mockApiDataSource.getUserById(tUserId),
        ).thenThrow(ServerException('User not found'));

        final result = await repository.getUserById(tUserId);

        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'User not found');
        }, (user) => fail('should return failure'));
      });
    });

    group('createUser', () {
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
      final tCreatedUser = UserModel(
        id: '1',
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: const [],
      );

      test('should return created user when API call is successful', () async {
        when(
          () => mockApiDataSource.createUser(any()),
        ).thenAnswer((_) async => tCreatedUser);

        final result = await repository.createUser(tUser);

        expect(result, isA<Right<Failure, UserEntity>>());
        result.fold((failure) => fail('should not return failure'), (user) {
          expect(user.id, '1');
          expect(user.name, 'John');
        });
        verify(() => mockApiDataSource.createUser(any())).called(1);
      });

      test('should return ServerFailure when API call fails', () async {
        when(
          () => mockApiDataSource.createUser(any()),
        ).thenThrow(ServerException('Creation failed'));

        final result = await repository.createUser(tUser);

        expect(result, isA<Left<Failure, UserEntity>>());
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Creation failed');
        }, (user) => fail('should return failure'));
      });
    });

    group('updateUser', () {
      final tUser = UserEntity(
        id: '1',
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: const [],
      );

      test('should return updated user when API call is successful', () async {
        when(() => mockApiDataSource.updateUser(any())).thenAnswer(
          (_) async => UserModel(
            id: '1',
            name: 'John Updated',
            lastName: 'Doe',
            birthDate: DateTime(1990, 1, 1),
            addresses: const [],
          ),
        );

        final result = await repository.updateUser(tUser);

        expect(result, isA<Right<Failure, UserEntity>>());
        verify(() => mockApiDataSource.updateUser(any())).called(1);
      });
    });

    group('deleteUser', () {
      const tUserId = '1';

      test('should return true when API call is successful', () async {
        when(
          () => mockApiDataSource.deleteUser(tUserId),
        ).thenAnswer((_) async => true);

        final result = await repository.deleteUser(tUserId);

        expect(result, isA<Right<Failure, bool>>());
        result.fold(
          (failure) => fail('should not return failure'),
          (success) => expect(success, true),
        );
        verify(() => mockApiDataSource.deleteUser(tUserId)).called(1);
      });

      test('should return ServerFailure when API call fails', () async {
        when(
          () => mockApiDataSource.deleteUser(tUserId),
        ).thenThrow(ServerException('Delete failed'));

        final result = await repository.deleteUser(tUserId);

        expect(result, isA<Left<Failure, bool>>());
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, 'Delete failed');
        }, (success) => fail('should return failure'));
      });
    });
  });
}
