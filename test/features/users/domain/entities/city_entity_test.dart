import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';
import 'package:double_v_partners_test/features/users/domain/entities/city_entity.dart';

void main() {
  group('CityEntity', () {
    test('should be a subclass of Equatable', () {
      // Arrange
      const city = CityEntity(id: '1', name: 'Medellín', stateId: '1');

      // Assert
      expect(city, isA<Equatable>());
    });

    test('should have correct properties', () {
      // Arrange
      const city = CityEntity(id: '1', name: 'Medellín', stateId: '1');

      // Assert
      expect(city.id, equals('1'));
      expect(city.name, equals('Medellín'));
      expect(city.stateId, equals('1'));
    });

    test('should support equality', () {
      // Arrange
      const city1 = CityEntity(id: '1', name: 'Medellín', stateId: '1');
      const city2 = CityEntity(id: '1', name: 'Medellín', stateId: '1');

      // Assert
      expect(city1, equals(city2));
      expect(city1.hashCode, equals(city2.hashCode));
    });

    test('should support inequality', () {
      // Arrange
      const city1 = CityEntity(id: '1', name: 'Medellín', stateId: '1');
      const city2 = CityEntity(id: '2', name: 'Bogotá', stateId: '1');

      // Assert
      expect(city1, isNot(equals(city2)));
    });

    test('should support inequality by stateId', () {
      // Arrange
      const city1 = CityEntity(id: '1', name: 'Medellín', stateId: '1');
      const city2 = CityEntity(id: '1', name: 'Medellín', stateId: '2');

      // Assert
      expect(city1, isNot(equals(city2)));
    });

    test('should have correct string representation', () {
      // Arrange
      const city = CityEntity(id: '1', name: 'Medellín', stateId: '1');

      // Act
      final stringRepresentation = city.toString();

      // Assert
      expect(stringRepresentation, contains('CityEntity'));
      expect(stringRepresentation, contains('1'));
      expect(stringRepresentation, contains('Medellín'));
    });

    test('should handle empty name', () {
      // Arrange
      const city = CityEntity(id: '1', name: '', stateId: '1');

      // Assert
      expect(city.name, equals(''));
    });

    test('should handle special characters in name', () {
      // Arrange
      const city = CityEntity(id: '1', name: 'São Paulo', stateId: '1');

      // Assert
      expect(city.name, equals('São Paulo'));
    });
  });
}
