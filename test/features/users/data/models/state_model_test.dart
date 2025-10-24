import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';
import 'package:double_v_partners_test/features/users/data/models/state_model.dart';
import 'package:double_v_partners_test/features/users/domain/entities/state_entity.dart';

void main() {
  group('StateModel', () {
    test('should be a subclass of Equatable', () {
      // Arrange
      const model = StateModel(
        id: 'CO_Antioquia',
        name: 'Antioquia',
        countryId: 'CO',
      );

      // Assert
      expect(model, isA<Equatable>());
    });

    test('should create StateModel from JSON', () {
      // Arrange
      final json = {'name': 'Antioquia'};
      const countryId = 'CO';

      // Act
      final model = StateModel.fromJson(json, countryId);

      // Assert
      expect(model.id, equals('CO_Antioquia'));
      expect(model.name, equals('Antioquia'));
      expect(model.countryId, equals('CO'));
    });

    test('should handle null name in JSON', () {
      // Arrange
      final json = <String, dynamic>{};
      const countryId = 'CO';

      // Act
      final model = StateModel.fromJson(json, countryId);

      // Assert
      expect(model.id, equals('CO_null'));
      expect(model.name, equals(''));
      expect(model.countryId, equals('CO'));
    });

    test('should convert to JSON', () {
      // Arrange
      const model = StateModel(
        id: 'CO_Antioquia',
        name: 'Antioquia',
        countryId: 'CO',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['id'], equals('CO_Antioquia'));
      expect(json['name'], equals('Antioquia'));
      expect(json['country_id'], equals('CO'));
    });

    test('should convert to domain entity', () {
      // Arrange
      const model = StateModel(
        id: 'CO_Antioquia',
        name: 'Antioquia',
        countryId: 'CO',
      );

      // Act
      final entity = model.toDomain();

      // Assert
      expect(entity, isA<StateEntity>());
      expect(entity.id, equals('CO_Antioquia'));
      expect(entity.name, equals('Antioquia'));
      expect(entity.countryId, equals('CO'));
    });

    test('should support equality', () {
      // Arrange
      const model1 = StateModel(
        id: 'CO_Antioquia',
        name: 'Antioquia',
        countryId: 'CO',
      );
      const model2 = StateModel(
        id: 'CO_Antioquia',
        name: 'Antioquia',
        countryId: 'CO',
      );

      // Assert
      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('should support inequality', () {
      // Arrange
      const model1 = StateModel(
        id: 'CO_Antioquia',
        name: 'Antioquia',
        countryId: 'CO',
      );
      const model2 = StateModel(
        id: 'CO_Cundinamarca',
        name: 'Cundinamarca',
        countryId: 'CO',
      );

      // Assert
      expect(model1, isNot(equals(model2)));
    });

    test('should have correct string representation', () {
      // Arrange
      const model = StateModel(
        id: 'CO_Antioquia',
        name: 'Antioquia',
        countryId: 'CO',
      );

      // Act
      final stringRepresentation = model.toString();

      // Assert
      expect(stringRepresentation, contains('StateModel'));
      expect(stringRepresentation, contains('CO_Antioquia'));
      expect(stringRepresentation, contains('Antioquia'));
      expect(stringRepresentation, contains('CO'));
    });

    test('should generate correct ID format', () {
      // Arrange
      final json = {'name': 'Cundinamarca'};
      const countryId = 'CO';

      // Act
      final model = StateModel.fromJson(json, countryId);

      // Assert
      expect(model.id, equals('CO_Cundinamarca'));
      expect(model.id, startsWith('CO_'));
    });
  });
}
