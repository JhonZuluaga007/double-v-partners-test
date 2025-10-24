import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:double_v_partners_test/features/users/data/datasources/geo_local_datasource.dart';
import 'package:double_v_partners_test/features/users/data/models/country_model.dart';
import 'package:double_v_partners_test/features/users/data/models/state_model.dart';
import 'package:double_v_partners_test/features/users/data/models/city_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GeoLocalDataSourceImpl', () {
    late GeoLocalDataSourceImpl dataSource;

    setUp(() {
      dataSource = GeoLocalDataSourceImpl();
    });

    group('getCountries', () {
      test(
        'should return list of countries when data is loaded successfully',
        () async {
          // Arrange
          const mockGeoData = '''
        [
          {
            "iso2": "CO",
            "name": "Colombia",
            "phone_code": "+57",
            "states": [
              {
                "name": "Antioquia",
                "cities": [
                  {"name": "Medellín"}
                ]
              }
            ]
          }
        ]
        ''';

          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
              .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
                MethodCall methodCall,
              ) async {
                if (methodCall.method == 'loadString' &&
                    methodCall.arguments == 'assets/geo_data.json') {
                  return mockGeoData;
                }
                return null;
              });

          // Act
          final result = await dataSource.getCountries();

          // Assert
          expect(result, isA<List<CountryModel>>());
          expect(result.length, equals(1));
          expect(result.first.id, equals('CO'));
          expect(result.first.name, equals('Colombia'));
          expect(result.first.iso2, equals('CO'));
          expect(result.first.phoneCode, equals('+57'));
        },
      );

      test('should throw exception when geo data file fails to load', () async {
        // Arrange
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
              MethodCall methodCall,
            ) async {
              throw PlatformException(code: 'FILE_NOT_FOUND');
            });

        // Act & Assert
        expect(() => dataSource.getCountries(), throwsA(isA<Exception>()));
      });

      test('should cache data after first load', () async {
        // Arrange
        const mockGeoData = '''
        [
          {
            "iso2": "CO",
            "name": "Colombia",
            "phone_code": "+57",
            "states": []
          }
        ]
        ''';

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
              MethodCall methodCall,
            ) async {
              return mockGeoData;
            });

        // Act
        await dataSource.getCountries();
        final result = await dataSource.getCountries();

        // Assert
        expect(result.length, equals(1));
        expect(result.first.name, equals('Colombia'));
      });
    });

    group('getStatesByCountry', () {
      test('should return states for valid country ID', () async {
        // Arrange
        const mockGeoData = '''
        [
          {
            "iso2": "CO",
            "name": "Colombia",
            "phone_code": "+57",
            "states": [
              {
                "name": "Antioquia",
                "cities": []
              },
              {
                "name": "Cundinamarca",
                "cities": []
              }
            ]
          }
        ]
        ''';

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
              MethodCall methodCall,
            ) async {
              return mockGeoData;
            });

        // Act
        final result = await dataSource.getStatesByCountry('CO');

        // Assert
        expect(result, isA<List<StateModel>>());
        expect(result.length, equals(2));
        expect(result[0].name, equals('Antioquia'));
        expect(result[0].countryId, equals('CO'));
        expect(result[0].id, equals('CO_Antioquia'));
        expect(result[1].name, equals('Cundinamarca'));
        expect(result[1].countryId, equals('CO'));
        expect(result[1].id, equals('CO_Cundinamarca'));
      });

      test('should throw exception when country not found', () async {
        // Arrange
        const mockGeoData = '''
        [
          {
            "iso2": "CO",
            "name": "Colombia",
            "phone_code": "+57",
            "states": []
          }
        ]
        ''';

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
              MethodCall methodCall,
            ) async {
              return mockGeoData;
            });

        // Act & Assert
        expect(
          () => dataSource.getStatesByCountry('US'),
          throwsA(isA<Exception>()),
        );
      });

      test('should return empty list when country has no states', () async {
        // Arrange
        const mockGeoData = '''
        [
          {
            "iso2": "CO",
            "name": "Colombia",
            "phone_code": "+57",
            "states": []
          }
        ]
        ''';

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
              MethodCall methodCall,
            ) async {
              return mockGeoData;
            });

        // Act
        final result = await dataSource.getStatesByCountry('CO');

        // Assert
        expect(result, isEmpty);
      });
    });

    group('getCitiesByState', () {
      test('should return cities for valid state ID', () async {
        // Arrange
        const mockGeoData = '''
        [
          {
            "iso2": "CO",
            "name": "Colombia",
            "phone_code": "+57",
            "states": [
              {
                "name": "Antioquia",
                "cities": [
                  {"name": "Medellín"},
                  {"name": "Bello"}
                ]
              }
            ]
          }
        ]
        ''';

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
              MethodCall methodCall,
            ) async {
              return mockGeoData;
            });

        // Act
        final result = await dataSource.getCitiesByState('CO_Antioquia');

        // Assert
        expect(result, isA<List<CityModel>>());
        expect(result.length, equals(2));
        expect(result[0].name, equals('Medellín'));
        expect(result[0].stateId, equals('CO_Antioquia'));
        expect(result[0].id, equals('CO_Antioquia_Medellín'));
        expect(result[1].name, equals('Bello'));
        expect(result[1].stateId, equals('CO_Antioquia'));
        expect(result[1].id, equals('CO_Antioquia_Bello'));
      });

      test('should throw exception when state not found', () async {
        // Arrange
        const mockGeoData = '''
        [
          {
            "iso2": "CO",
            "name": "Colombia",
            "phone_code": "+57",
            "states": [
              {
                "name": "Antioquia",
                "cities": []
              }
            ]
          }
        ]
        ''';

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
              MethodCall methodCall,
            ) async {
              return mockGeoData;
            });

        // Act & Assert
        expect(
          () => dataSource.getCitiesByState('CO_Nonexistent'),
          throwsA(isA<Exception>()),
        );
      });

      test('should return empty list when state has no cities', () async {
        // Arrange
        const mockGeoData = '''
        [
          {
            "iso2": "CO",
            "name": "Colombia",
            "phone_code": "+57",
            "states": [
              {
                "name": "Antioquia",
                "cities": []
              }
            ]
          }
        ]
        ''';

        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(const MethodChannel('flutter/assets'), (
              MethodCall methodCall,
            ) async {
              return mockGeoData;
            });

        // Act
        final result = await dataSource.getCitiesByState('CO_Antioquia');

        // Assert
        expect(result, isEmpty);
      });
    });
  });
}
