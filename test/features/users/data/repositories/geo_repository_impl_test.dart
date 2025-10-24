import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:double_v_partners_test/core/error/failures.dart';
import 'package:double_v_partners_test/features/users/data/datasources/geo_local_datasource.dart';
import 'package:double_v_partners_test/features/users/data/models/country_model.dart';
import 'package:double_v_partners_test/features/users/data/models/state_model.dart';
import 'package:double_v_partners_test/features/users/data/models/city_model.dart';
import 'package:double_v_partners_test/features/users/data/repositories/geo_repository_impl.dart';
import 'package:double_v_partners_test/features/users/domain/entities/country_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/state_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/city_entity.dart';

class MockGeoLocalDataSource extends Mock implements GeoLocalDataSource {}

void main() {
  group('GeoRepositoryImpl', () {
    late GeoRepositoryImpl repository;
    late MockGeoLocalDataSource mockLocalDataSource;

    setUp(() {
      mockLocalDataSource = MockGeoLocalDataSource();
      repository = GeoRepositoryImpl(localDataSource: mockLocalDataSource);
    });

    group('getCountries', () {
      test(
        'should return countries when local data source call is successful',
        () async {
          // Arrange
          final mockCountries = [
            const CountryModel(
              id: 'CO',
              name: 'Colombia',
              iso2: 'CO',
              phoneCode: '+57',
            ),
            const CountryModel(
              id: 'PE',
              name: 'Peru',
              iso2: 'PE',
              phoneCode: '+51',
            ),
          ];

          when(
            () => mockLocalDataSource.getCountries(),
          ).thenAnswer((_) async => mockCountries);

          // Act
          final result = await repository.getCountries();

          // Assert
          expect(result, isA<Right<Failure, List<CountryEntity>>>());
          result.fold((failure) => fail('Should not return failure'), (
            countries,
          ) {
            expect(countries.length, equals(2));
            expect(countries[0], isA<CountryEntity>());
            expect(countries[0].id, equals('CO'));
            expect(countries[0].name, equals('Colombia'));
            expect(countries[1].id, equals('PE'));
            expect(countries[1].name, equals('Peru'));
          });

          verify(() => mockLocalDataSource.getCountries()).called(1);
        },
      );

      test(
        'should return GeneralFailure when local data source throws exception',
        () async {
          // Arrange
          when(
            () => mockLocalDataSource.getCountries(),
          ).thenThrow(Exception('Error loading data'));

          // Act
          final result = await repository.getCountries();

          // Assert
          expect(result, isA<Left<Failure, List<CountryEntity>>>());
          result.fold((failure) {
            expect(failure, isA<GeneralFailure>());
            expect(failure.message, contains('Error loading data'));
          }, (countries) => fail('Should not return success'));

          verify(() => mockLocalDataSource.getCountries()).called(1);
        },
      );

      test('should return empty list when no countries exist', () async {
        // Arrange
        when(
          () => mockLocalDataSource.getCountries(),
        ).thenAnswer((_) async => <CountryModel>[]);

        // Act
        final result = await repository.getCountries();

        // Assert
        expect(result, isA<Right<Failure, List<CountryEntity>>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (countries) => expect(countries, isEmpty),
        );

        verify(() => mockLocalDataSource.getCountries()).called(1);
      });
    });

    group('getStatesByCountry', () {
      test(
        'should return states when local data source call is successful',
        () async {
          // Arrange
          const countryId = 'CO';
          final mockStates = [
            const StateModel(
              id: 'CO_Antioquia',
              name: 'Antioquia',
              countryId: 'CO',
            ),
            const StateModel(
              id: 'CO_Cundinamarca',
              name: 'Cundinamarca',
              countryId: 'CO',
            ),
          ];

          when(
            () => mockLocalDataSource.getStatesByCountry(countryId),
          ).thenAnswer((_) async => mockStates);

          // Act
          final result = await repository.getStatesByCountry(countryId);

          // Assert
          expect(result, isA<Right<Failure, List<StateEntity>>>());
          result.fold((failure) => fail('Should not return failure'), (states) {
            expect(states.length, equals(2));
            expect(states[0], isA<StateEntity>());
            expect(states[0].id, equals('CO_Antioquia'));
            expect(states[0].name, equals('Antioquia'));
            expect(states[0].countryId, equals('CO'));
            expect(states[1].id, equals('CO_Cundinamarca'));
            expect(states[1].name, equals('Cundinamarca'));
          });

          verify(
            () => mockLocalDataSource.getStatesByCountry(countryId),
          ).called(1);
        },
      );

      test(
        'should return GeneralFailure when local data source throws exception',
        () async {
          // Arrange
          const countryId = 'INVALID';
          when(
            () => mockLocalDataSource.getStatesByCountry(countryId),
          ).thenThrow(Exception('Country not found'));

          // Act
          final result = await repository.getStatesByCountry(countryId);

          // Assert
          expect(result, isA<Left<Failure, List<StateEntity>>>());
          result.fold((failure) {
            expect(failure, isA<GeneralFailure>());
            expect(failure.message, contains('Country not found'));
          }, (states) => fail('Should not return success'));

          verify(
            () => mockLocalDataSource.getStatesByCountry(countryId),
          ).called(1);
        },
      );

      test('should return empty list when country has no states', () async {
        // Arrange
        const countryId = 'CO';
        when(
          () => mockLocalDataSource.getStatesByCountry(countryId),
        ).thenAnswer((_) async => <StateModel>[]);

        // Act
        final result = await repository.getStatesByCountry(countryId);

        // Assert
        expect(result, isA<Right<Failure, List<StateEntity>>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (states) => expect(states, isEmpty),
        );

        verify(
          () => mockLocalDataSource.getStatesByCountry(countryId),
        ).called(1);
      });
    });

    group('getCitiesByState', () {
      test(
        'should return cities when local data source call is successful',
        () async {
          // Arrange
          const stateId = 'CO_Antioquia';
          final mockCities = [
            const CityModel(
              id: 'CO_Antioquia_Medellín',
              name: 'Medellín',
              stateId: 'CO_Antioquia',
            ),
            const CityModel(
              id: 'CO_Antioquia_Bello',
              name: 'Bello',
              stateId: 'CO_Antioquia',
            ),
          ];

          when(
            () => mockLocalDataSource.getCitiesByState(stateId),
          ).thenAnswer((_) async => mockCities);

          // Act
          final result = await repository.getCitiesByState(stateId);

          // Assert
          expect(result, isA<Right<Failure, List<CityEntity>>>());
          result.fold((failure) => fail('Should not return failure'), (cities) {
            expect(cities.length, equals(2));
            expect(cities[0], isA<CityEntity>());
            expect(cities[0].id, equals('CO_Antioquia_Medellín'));
            expect(cities[0].name, equals('Medellín'));
            expect(cities[0].stateId, equals('CO_Antioquia'));
            expect(cities[1].id, equals('CO_Antioquia_Bello'));
            expect(cities[1].name, equals('Bello'));
          });

          verify(() => mockLocalDataSource.getCitiesByState(stateId)).called(1);
        },
      );

      test(
        'should return GeneralFailure when local data source throws exception',
        () async {
          // Arrange
          const stateId = 'INVALID_STATE';
          when(
            () => mockLocalDataSource.getCitiesByState(stateId),
          ).thenThrow(Exception('State not found'));

          // Act
          final result = await repository.getCitiesByState(stateId);

          // Assert
          expect(result, isA<Left<Failure, List<CityEntity>>>());
          result.fold((failure) {
            expect(failure, isA<GeneralFailure>());
            expect(failure.message, contains('State not found'));
          }, (cities) => fail('Should not return success'));

          verify(() => mockLocalDataSource.getCitiesByState(stateId)).called(1);
        },
      );

      test('should return empty list when state has no cities', () async {
        // Arrange
        const stateId = 'CO_Antioquia';
        when(
          () => mockLocalDataSource.getCitiesByState(stateId),
        ).thenAnswer((_) async => <CityModel>[]);

        // Act
        final result = await repository.getCitiesByState(stateId);

        // Assert
        expect(result, isA<Right<Failure, List<CityEntity>>>());
        result.fold(
          (failure) => fail('Should not return failure'),
          (cities) => expect(cities, isEmpty),
        );

        verify(() => mockLocalDataSource.getCitiesByState(stateId)).called(1);
      });
    });
  });
}
