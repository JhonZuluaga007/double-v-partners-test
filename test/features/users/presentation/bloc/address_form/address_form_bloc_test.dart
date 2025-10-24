import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:double_v_partners_test/core/error/failures.dart';
import 'package:double_v_partners_test/features/users/domain/entities/country_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/state_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/city_entity.dart';
import 'package:double_v_partners_test/features/users/domain/repositories/geo_repository.dart';
import 'package:double_v_partners_test/features/users/presentation/bloc/address_form/address_form_bloc.dart';
import 'package:double_v_partners_test/features/users/presentation/bloc/address_form/address_form_event.dart';
import 'package:double_v_partners_test/features/users/presentation/bloc/address_form/address_form_state.dart';

class MockGeoRepository extends Mock implements GeoRepository {}

void main() {
  group('AddressFormBloc', () {
    late AddressFormBloc addressFormBloc;
    late MockGeoRepository mockGeoRepository;

    setUpAll(() {
      registerFallbackValue(
        const CountryEntity(
          id: 'CO',
          name: 'Colombia',
          iso2: 'CO',
          phoneCode: '+57',
        ),
      );
      registerFallbackValue(
        const StateEntity(
          id: 'CO_Antioquia',
          name: 'Antioquia',
          countryId: 'CO',
        ),
      );
      registerFallbackValue(
        const CityEntity(
          id: 'CO_Antioquia_Medellín',
          name: 'Medellín',
          stateId: 'CO_Antioquia',
        ),
      );
    });

    setUp(() {
      mockGeoRepository = MockGeoRepository();
      addressFormBloc = AddressFormBloc(geoRepository: mockGeoRepository);
    });

    tearDown(() {
      addressFormBloc.close();
    });

    test('initial state should be AddressFormState.initial()', () {
      // Assert
      expect(addressFormBloc.state, equals(const AddressFormState()));
      expect(addressFormBloc.state.status, equals(AddressFormStatus.initial));
      expect(addressFormBloc.state.countries, isEmpty);
      expect(addressFormBloc.state.states, isEmpty);
      expect(addressFormBloc.state.cities, isEmpty);
      expect(addressFormBloc.state.selectedCountry, isNull);
      expect(addressFormBloc.state.selectedState, isNull);
      expect(addressFormBloc.state.selectedCity, isNull);
    });

    group('LoadCountries', () {
      test(
        'should emit [loading, success] when countries are loaded successfully',
        () async {
          // Arrange
          final mockCountries = [
            const CountryEntity(
              id: 'CO',
              name: 'Colombia',
              iso2: 'CO',
              phoneCode: '+57',
            ),
            const CountryEntity(
              id: 'PE',
              name: 'Peru',
              iso2: 'PE',
              phoneCode: '+51',
            ),
          ];

          when(
            () => mockGeoRepository.getCountries(),
          ).thenAnswer((_) async => Right(mockCountries));

          // Act & Assert
          blocTest<AddressFormBloc, AddressFormState>(
            'should emit [loading, success] when countries are loaded successfully',
            build: () => addressFormBloc,
            act: (bloc) => bloc.add(const LoadCountries()),
            expect: () => [
              const AddressFormState(status: AddressFormStatus.loading),
              AddressFormState(
                status: AddressFormStatus.success,
                countries: mockCountries,
              ),
            ],
            verify: (_) {
              verify(() => mockGeoRepository.getCountries()).called(1);
            },
          );
        },
      );

      test(
        'should emit [loading, error] when repository returns failure',
        () async {
          // Arrange
          const failure = GeneralFailure('Error loading countries');

          when(
            () => mockGeoRepository.getCountries(),
          ).thenAnswer((_) async => const Left(failure));

          // Act & Assert
          blocTest<AddressFormBloc, AddressFormState>(
            'should emit [loading, error] when repository returns failure',
            build: () => addressFormBloc,
            act: (bloc) => bloc.add(const LoadCountries()),
            expect: () => [
              const AddressFormState(status: AddressFormStatus.loading),
              const AddressFormState(
                status: AddressFormStatus.error,
                errorMessage: 'Error loading countries',
              ),
            ],
            verify: (_) {
              verify(() => mockGeoRepository.getCountries()).called(1);
            },
          );
        },
      );
    });

    group('CountrySelected', () {
      test(
        'should emit [loading, success] when states are loaded successfully',
        () async {
          // Arrange
          const selectedCountry = CountryEntity(
            id: 'CO',
            name: 'Colombia',
            iso2: 'CO',
            phoneCode: '+57',
          );

          final mockStates = [
            const StateEntity(
              id: 'CO_Antioquia',
              name: 'Antioquia',
              countryId: 'CO',
            ),
            const StateEntity(
              id: 'CO_Cundinamarca',
              name: 'Cundinamarca',
              countryId: 'CO',
            ),
          ];

          when(
            () => mockGeoRepository.getStatesByCountry('CO'),
          ).thenAnswer((_) async => Right(mockStates));

          // Act & Assert
          blocTest<AddressFormBloc, AddressFormState>(
            'should emit [loading, success] when states are loaded successfully',
            build: () => addressFormBloc,
            act: (bloc) => bloc.add(CountrySelected(selectedCountry)),
            expect: () => [
              AddressFormState(
                status: AddressFormStatus.loading,
                selectedCountry: selectedCountry,
                selectedState: null,
                selectedCity: null,
                states: const [],
                cities: const [],
              ),
              AddressFormState(
                status: AddressFormStatus.success,
                selectedCountry: selectedCountry,
                selectedState: null,
                selectedCity: null,
                states: mockStates,
                cities: const [],
              ),
            ],
            verify: (_) {
              verify(
                () => mockGeoRepository.getStatesByCountry('CO'),
              ).called(1);
            },
          );
        },
      );

      test(
        'should emit [loading, error] when repository returns failure',
        () async {
          // Arrange
          const selectedCountry = CountryEntity(
            id: 'CO',
            name: 'Colombia',
            iso2: 'CO',
            phoneCode: '+57',
          );

          const failure = GeneralFailure('Error loading states');

          when(
            () => mockGeoRepository.getStatesByCountry('CO'),
          ).thenAnswer((_) async => const Left(failure));

          // Act & Assert
          blocTest<AddressFormBloc, AddressFormState>(
            'should emit [loading, error] when repository returns failure',
            build: () => addressFormBloc,
            act: (bloc) => bloc.add(CountrySelected(selectedCountry)),
            expect: () => [
              AddressFormState(
                status: AddressFormStatus.loading,
                selectedCountry: selectedCountry,
                selectedState: null,
                selectedCity: null,
                states: const [],
                cities: const [],
              ),
              AddressFormState(
                status: AddressFormStatus.error,
                selectedCountry: selectedCountry,
                selectedState: null,
                selectedCity: null,
                states: const [],
                cities: const [],
                errorMessage: 'Error loading states',
              ),
            ],
            verify: (_) {
              verify(
                () => mockGeoRepository.getStatesByCountry('CO'),
              ).called(1);
            },
          );
        },
      );
    });

    group('StateSelected', () {
      test(
        'should emit [loading, success] when cities are loaded successfully',
        () async {
          // Arrange
          const selectedState = StateEntity(
            id: 'CO_Antioquia',
            name: 'Antioquia',
            countryId: 'CO',
          );

          final mockCities = [
            const CityEntity(
              id: 'CO_Antioquia_Medellín',
              name: 'Medellín',
              stateId: 'CO_Antioquia',
            ),
            const CityEntity(
              id: 'CO_Antioquia_Bello',
              name: 'Bello',
              stateId: 'CO_Antioquia',
            ),
          ];

          when(
            () => mockGeoRepository.getCitiesByState('CO_Antioquia'),
          ).thenAnswer((_) async => Right(mockCities));

          // Act & Assert
          blocTest<AddressFormBloc, AddressFormState>(
            'should emit [loading, success] when cities are loaded successfully',
            build: () => addressFormBloc,
            act: (bloc) => bloc.add(StateSelected(selectedState)),
            expect: () => [
              AddressFormState(
                status: AddressFormStatus.loading,
                selectedState: selectedState,
                selectedCity: null,
                cities: const [],
              ),
              AddressFormState(
                status: AddressFormStatus.success,
                selectedState: selectedState,
                selectedCity: null,
                cities: mockCities,
              ),
            ],
            verify: (_) {
              verify(
                () => mockGeoRepository.getCitiesByState('CO_Antioquia'),
              ).called(1);
            },
          );
        },
      );

      test(
        'should emit [loading, error] when repository returns failure',
        () async {
          // Arrange
          const selectedState = StateEntity(
            id: 'CO_Antioquia',
            name: 'Antioquia',
            countryId: 'CO',
          );

          const failure = GeneralFailure('Error loading cities');

          when(
            () => mockGeoRepository.getCitiesByState('CO_Antioquia'),
          ).thenAnswer((_) async => const Left(failure));

          // Act & Assert
          blocTest<AddressFormBloc, AddressFormState>(
            'should emit [loading, error] when repository returns failure',
            build: () => addressFormBloc,
            act: (bloc) => bloc.add(StateSelected(selectedState)),
            expect: () => [
              AddressFormState(
                status: AddressFormStatus.loading,
                selectedState: selectedState,
                selectedCity: null,
                cities: const [],
              ),
              AddressFormState(
                status: AddressFormStatus.error,
                selectedState: selectedState,
                selectedCity: null,
                cities: const [],
                errorMessage: 'Error loading cities',
              ),
            ],
            verify: (_) {
              verify(
                () => mockGeoRepository.getCitiesByState('CO_Antioquia'),
              ).called(1);
            },
          );
        },
      );
    });

    group('CitySelected', () {
      test('should emit success state with selected city', () async {
        // Arrange
        const selectedCity = CityEntity(
          id: 'CO_Antioquia_Medellín',
          name: 'Medellín',
          stateId: 'CO_Antioquia',
        );

        // Act & Assert
        blocTest<AddressFormBloc, AddressFormState>(
          'should emit success state with selected city',
          build: () => addressFormBloc,
          act: (bloc) => bloc.add(CitySelected(selectedCity)),
          expect: () => [
            AddressFormState(
              status: AddressFormStatus.success,
              selectedCity: selectedCity,
            ),
          ],
        );
      });
    });

    group('ResetForm', () {
      test('should reset form to initial state', () async {
        // Arrange
        const selectedCountry = CountryEntity(
          id: 'CO',
          name: 'Colombia',
          iso2: 'CO',
          phoneCode: '+57',
        );

        const selectedState = StateEntity(
          id: 'CO_Antioquia',
          name: 'Antioquia',
          countryId: 'CO',
        );

        const selectedCity = CityEntity(
          id: 'CO_Antioquia_Medellín',
          name: 'Medellín',
          stateId: 'CO_Antioquia',
        );

        // Act & Assert
        blocTest<AddressFormBloc, AddressFormState>(
          'should reset form to initial state',
          build: () => addressFormBloc,
          seed: () => AddressFormState(
            selectedCountry: selectedCountry,
            selectedState: selectedState,
            selectedCity: selectedCity,
          ),
          act: (bloc) => bloc.add(const ResetForm()),
          expect: () => [const AddressFormState()],
        );
      });
    });

    group('Multiple Events', () {
      test('should handle multiple events correctly', () async {
        // Arrange
        const selectedCountry = CountryEntity(
          id: 'CO',
          name: 'Colombia',
          iso2: 'CO',
          phoneCode: '+57',
        );

        const selectedState = StateEntity(
          id: 'CO_Antioquia',
          name: 'Antioquia',
          countryId: 'CO',
        );

        const selectedCity = CityEntity(
          id: 'CO_Antioquia_Medellín',
          name: 'Medellín',
          stateId: 'CO_Antioquia',
        );

        final mockCountries = [selectedCountry];
        final mockStates = [selectedState];
        final mockCities = [selectedCity];

        when(
          () => mockGeoRepository.getCountries(),
        ).thenAnswer((_) async => Right(mockCountries));
        when(
          () => mockGeoRepository.getStatesByCountry('CO'),
        ).thenAnswer((_) async => Right(mockStates));
        when(
          () => mockGeoRepository.getCitiesByState('CO_Antioquia'),
        ).thenAnswer((_) async => Right(mockCities));

        // Act & Assert
        blocTest<AddressFormBloc, AddressFormState>(
          'should handle multiple events correctly',
          build: () => addressFormBloc,
          act: (bloc) async {
            bloc.add(const LoadCountries());
            await Future.delayed(const Duration(milliseconds: 100));
            bloc.add(CountrySelected(selectedCountry));
            await Future.delayed(const Duration(milliseconds: 100));
            bloc.add(StateSelected(selectedState));
            await Future.delayed(const Duration(milliseconds: 100));
            bloc.add(CitySelected(selectedCity));
          },
          expect: () => [
            // LoadCountries
            const AddressFormState(status: AddressFormStatus.loading),
            AddressFormState(
              status: AddressFormStatus.success,
              countries: mockCountries,
            ),
            // CountrySelected
            AddressFormState(
              status: AddressFormStatus.loading,
              countries: mockCountries,
              selectedCountry: selectedCountry,
              selectedState: null,
              selectedCity: null,
              states: const [],
              cities: const [],
            ),
            AddressFormState(
              status: AddressFormStatus.success,
              countries: mockCountries,
              selectedCountry: selectedCountry,
              selectedState: null,
              selectedCity: null,
              states: mockStates,
              cities: const [],
            ),
            // StateSelected
            AddressFormState(
              status: AddressFormStatus.loading,
              countries: mockCountries,
              selectedCountry: selectedCountry,
              selectedState: selectedState,
              selectedCity: null,
              states: mockStates,
              cities: const [],
            ),
            AddressFormState(
              status: AddressFormStatus.success,
              countries: mockCountries,
              selectedCountry: selectedCountry,
              selectedState: selectedState,
              selectedCity: null,
              states: mockStates,
              cities: mockCities,
            ),
            // CitySelected
            AddressFormState(
              status: AddressFormStatus.success,
              countries: mockCountries,
              selectedCountry: selectedCountry,
              selectedState: selectedState,
              selectedCity: selectedCity,
              states: mockStates,
              cities: mockCities,
            ),
          ],
        );
      });
    });
  });
}
