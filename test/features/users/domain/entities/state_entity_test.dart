import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';
import 'package:double_v_partners_test/features/users/domain/entities/state_entity.dart';

void main() {
  group('StateEntity', () {
    test('should be a subclass of Equatable', () {
      // Arrange
      const state = StateEntity(id: '1', name: 'Antioquia', countryId: '1');

      // Assert
      expect(state, isA<Equatable>());
    });

    test('should have correct properties', () {
      // Arrange
      const state = StateEntity(id: '1', name: 'Antioquia', countryId: '1');

      // Assert
      expect(state.id, equals('1'));
      expect(state.name, equals('Antioquia'));
      expect(state.countryId, equals('1'));
    });

    test('should support equality', () {
      // Arrange
      const state1 = StateEntity(id: '1', name: 'Antioquia', countryId: '1');
      const state2 = StateEntity(id: '1', name: 'Antioquia', countryId: '1');

      // Assert
      expect(state1, equals(state2));
      expect(state1.hashCode, equals(state2.hashCode));
    });

    test('should support inequality', () {
      // Arrange
      const state1 = StateEntity(id: '1', name: 'Antioquia', countryId: '1');
      const state2 = StateEntity(id: '2', name: 'Cundinamarca', countryId: '1');

      // Assert
      expect(state1, isNot(equals(state2)));
    });

    test('should support inequality by countryId', () {
      // Arrange
      const state1 = StateEntity(id: '1', name: 'Antioquia', countryId: '1');
      const state2 = StateEntity(id: '1', name: 'Antioquia', countryId: '2');

      // Assert
      expect(state1, isNot(equals(state2)));
    });

    test('should have correct string representation', () {
      // Arrange
      const state = StateEntity(id: '1', name: 'Antioquia', countryId: '1');

      // Act
      final stringRepresentation = state.toString();

      // Assert
      expect(stringRepresentation, contains('StateEntity'));
      expect(stringRepresentation, contains('1'));
      expect(stringRepresentation, contains('Antioquia'));
    });

    test('should handle empty name', () {
      // Arrange
      const state = StateEntity(id: '1', name: '', countryId: '1');

      // Assert
      expect(state.name, equals(''));
    });

    test('should handle special characters in name', () {
      // Arrange
      const state = StateEntity(id: '1', name: 'São Paulo', countryId: '1');

      // Assert
      expect(state.name, equals('São Paulo'));
    });
  });
}
