import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';
import 'package:double_v_partners_test/features/users/domain/entities/country_entity.dart';

void main() {
  group('CountryEntity', () {
    test('should be a subclass of Equatable', () {
      // Arrange
      const country = CountryEntity(
        id: '1',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Assert
      expect(country, isA<Equatable>());
    });

    test('should have correct properties', () {
      // Arrange
      const country = CountryEntity(
        id: '1',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Assert
      expect(country.id, equals('1'));
      expect(country.name, equals('Colombia'));
    });

    test('should support equality', () {
      // Arrange
      const country1 = CountryEntity(
        id: '1',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );
      const country2 = CountryEntity(
        id: '1',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Assert
      expect(country1, equals(country2));
      expect(country1.hashCode, equals(country2.hashCode));
    });

    test('should support inequality', () {
      // Arrange
      const country1 = CountryEntity(
        id: '1',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );
      const country2 = CountryEntity(
        id: '2',
        name: 'Peru',
        iso2: 'PE',
        phoneCode: '+51',
      );

      // Assert
      expect(country1, isNot(equals(country2)));
    });

    test('should have correct string representation', () {
      // Arrange
      const country = CountryEntity(
        id: '1',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Act
      final stringRepresentation = country.toString();

      // Assert
      expect(stringRepresentation, contains('CountryEntity'));
      expect(stringRepresentation, contains('1'));
      expect(stringRepresentation, contains('Colombia'));
    });

    test('should handle empty name', () {
      // Arrange
      const country = CountryEntity(
        id: '1',
        name: '',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Assert
      expect(country.name, equals(''));
    });

    test('should handle special characters in name', () {
      // Arrange
      const country = CountryEntity(
        id: '1',
        name: 'Côte d\'Ivoire',
        iso2: 'CI',
        phoneCode: '+225',
      );

      // Assert
      expect(country.name, equals('Côte d\'Ivoire'));
    });
  });
}
