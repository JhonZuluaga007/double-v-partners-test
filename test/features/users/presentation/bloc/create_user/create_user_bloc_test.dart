import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:double_v_partners_test/core/error/failures.dart';
import 'package:double_v_partners_test/features/users/domain/entities/address_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/user_entity.dart';
import 'package:double_v_partners_test/features/users/domain/usecases/create_user_usecase.dart';
import 'package:double_v_partners_test/features/users/presentation/bloc/create_user/create_user_bloc.dart';

class MockCreateUserUseCase extends Mock implements CreateUserUseCase {}

class FakeUserEntity extends Fake implements UserEntity {}

void main() {
  late CreateUserBloc createUserBloc;
  late MockCreateUserUseCase mockCreateUserUseCase;

  setUpAll(() {
    registerFallbackValue(FakeUserEntity());
  });

  setUp(() {
    mockCreateUserUseCase = MockCreateUserUseCase();
    createUserBloc = CreateUserBloc(createUserUseCase: mockCreateUserUseCase);
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

  test('initial state should be CreateUserState.initial()', () {
    expect(createUserBloc.state, const CreateUserState.initial());
  });

  group('Submit', () {
    blocTest<CreateUserBloc, CreateUserState>(
      'should emit [submitting, success] when createUserUseCase returns success',
      build: () {
        when(
          () => mockCreateUserUseCase(tUser),
        ).thenAnswer((_) async => Right(tCreatedUser));
        return createUserBloc;
      },
      act: (bloc) => bloc.add(CreateUserEvent.submit(tUser)),
      expect: () => [
        const CreateUserState.submitting(),
        CreateUserState.success(tCreatedUser),
      ],
      verify: (_) {
        verify(() => mockCreateUserUseCase(tUser)).called(1);
      },
    );

    blocTest<CreateUserBloc, CreateUserState>(
      'should emit [submitting, error] when createUserUseCase returns ServerFailure',
      build: () {
        when(
          () => mockCreateUserUseCase(tUser),
        ).thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return createUserBloc;
      },
      act: (bloc) => bloc.add(CreateUserEvent.submit(tUser)),
      expect: () => [
        const CreateUserState.submitting(),
        const CreateUserState.error('Server error'),
      ],
      verify: (_) {
        verify(() => mockCreateUserUseCase(tUser)).called(1);
      },
    );
  });

  group('Reset', () {
    blocTest<CreateUserBloc, CreateUserState>(
      'should emit [initial] when reset is called',
      build: () => createUserBloc,
      act: (bloc) => bloc.add(const CreateUserEvent.reset()),
      expect: () => [const CreateUserState.initial()],
      verify: (_) {
        verifyNever(() => mockCreateUserUseCase(any()));
      },
    );

    blocTest<CreateUserBloc, CreateUserState>(
      'should reset from success state to initial',
      build: () {
        when(
          () => mockCreateUserUseCase(tUser),
        ).thenAnswer((_) async => Right(tCreatedUser));
        return createUserBloc;
      },
      seed: () => CreateUserState.success(tCreatedUser),
      act: (bloc) => bloc.add(const CreateUserEvent.reset()),
      expect: () => [const CreateUserState.initial()],
      verify: (_) {
        verifyNever(() => mockCreateUserUseCase(any()));
      },
    );

    blocTest<CreateUserBloc, CreateUserState>(
      'should reset from error state to initial',
      build: () {
        when(
          () => mockCreateUserUseCase(tUser),
        ).thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return createUserBloc;
      },
      seed: () => const CreateUserState.error('Server error'),
      act: (bloc) => bloc.add(const CreateUserEvent.reset()),
      expect: () => [const CreateUserState.initial()],
      verify: (_) {
        verifyNever(() => mockCreateUserUseCase(any()));
      },
    );
  });

  group('Multiple Events', () {
    blocTest<CreateUserBloc, CreateUserState>(
      'should handle multiple submit events correctly',
      build: () {
        when(
          () => mockCreateUserUseCase(tUser),
        ).thenAnswer((_) async => Right(tCreatedUser));
        return createUserBloc;
      },
      act: (bloc) {
        bloc.add(CreateUserEvent.submit(tUser));
        bloc.add(CreateUserEvent.submit(tUser));
      },
      expect: () => [
        const CreateUserState.submitting(),
        CreateUserState.success(tCreatedUser),
        const CreateUserState.submitting(),
        CreateUserState.success(tCreatedUser),
      ],
      verify: (_) {
        verify(() => mockCreateUserUseCase(tUser)).called(2);
      },
    );

    blocTest<CreateUserBloc, CreateUserState>(
      'should handle submit and reset events correctly',
      build: () {
        when(
          () => mockCreateUserUseCase(tUser),
        ).thenAnswer((_) async => Right(tCreatedUser));
        return createUserBloc;
      },
      act: (bloc) {
        bloc.add(CreateUserEvent.submit(tUser));
        bloc.add(const CreateUserEvent.reset());
      },
      expect: () => [
        const CreateUserState.submitting(),
        CreateUserState.success(tCreatedUser),
        const CreateUserState.initial(),
      ],
      verify: (_) {
        verify(() => mockCreateUserUseCase(tUser)).called(1);
      },
    );
  });
}
