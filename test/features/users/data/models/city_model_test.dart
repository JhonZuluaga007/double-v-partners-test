import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';
import 'package:double_v_partners_test/features/users/data/models/city_model.dart';
import 'package:double_v_partners_test/features/users/domain/entities/city_entity.dart';

void main() {
  group('CityModel', () {
    test('should be a subclass of Equatable', () {
      // Arrange
      const model = CityModel(
        id: 'CO_Antioquia_Medellín',
        name: 'Medellín',
        stateId: 'CO_Antioquia',
      );

      // Assert
      expect(model, isA<Equatable>());
    });

    test('should create CityModel from JSON', () {
      // Arrange
      final json = {'name': 'Medellín'};
      const stateId = 'CO_Antioquia';

      // Act
      final model = CityModel.fromJson(json, stateId);

      // Assert
      expect(model.id, equals('CO_Antioquia_Medellín'));
      expect(model.name, equals('Medellín'));
      expect(model.stateId, equals('CO_Antioquia'));
    });

    test('should handle null name in JSON', () {
      // Arrange
      final json = <String, dynamic>{};
      const stateId = 'CO_Antioquia';

      // Act
      final model = CityModel.fromJson(json, stateId);

      // Assert
      expect(model.id, equals('CO_Antioquia_null'));
      expect(model.name, equals(''));
      expect(model.stateId, equals('CO_Antioquia'));
    });

    test('should convert to JSON', () {
      // Arrange
      const model = CityModel(
        id: 'CO_Antioquia_Medellín',
        name: 'Medellín',
        stateId: 'CO_Antioquia',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['id'], equals('CO_Antioquia_Medellín'));
      expect(json['name'], equals('Medellín'));
      expect(json['state_id'], equals('CO_Antioquia'));
    });

    test('should convert to domain entity', () {
      // Arrange
      const model = CityModel(
        id: 'CO_Antioquia_Medellín',
        name: 'Medellín',
        stateId: 'CO_Antioquia',
      );

      // Act
      final entity = model.toDomain();

      // Assert
      expect(entity, isA<CityEntity>());
      expect(entity.id, equals('CO_Antioquia_Medellín'));
      expect(entity.name, equals('Medellín'));
      expect(entity.stateId, equals('CO_Antioquia'));
    });

    test('should support equality', () {
      // Arrange
      const model1 = CityModel(
        id: 'CO_Antioquia_Medellín',
        name: 'Medellín',
        stateId: 'CO_Antioquia',
      );
      const model2 = CityModel(
        id: 'CO_Antioquia_Medellín',
        name: 'Medellín',
        stateId: 'CO_Antioquia',
      );

      // Assert
      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('should support inequality', () {
      // Arrange
      const model1 = CityModel(
        id: 'CO_Antioquia_Medellín',
        name: 'Medellín',
        stateId: 'CO_Antioquia',
      );
      const model2 = CityModel(
        id: 'CO_Antioquia_Bogotá',
        name: 'Bogotá',
        stateId: 'CO_Antioquia',
      );

      // Assert
      expect(model1, isNot(equals(model2)));
    });

    test('should have correct string representation', () {
      // Arrange
      const model = CityModel(
        id: 'CO_Antioquia_Medellín',
        name: 'Medellín',
        stateId: 'CO_Antioquia',
      );

      // Act
      final stringRepresentation = model.toString();

      // Assert
      expect(stringRepresentation, contains('CityModel'));
      expect(stringRepresentation, contains('CO_Antioquia_Medellín'));
      expect(stringRepresentation, contains('Medellín'));
      expect(stringRepresentation, contains('CO_Antioquia'));
    });

    test('should generate correct ID format', () {
      // Arrange
      final json = {'name': 'Bogotá'};
      const stateId = 'CO_Cundinamarca';

      // Act
      final model = CityModel.fromJson(json, stateId);

      // Assert
      expect(model.id, equals('CO_Cundinamarca_Bogotá'));
      expect(model.id, startsWith('CO_Cundinamarca_'));
    });
  });
}
