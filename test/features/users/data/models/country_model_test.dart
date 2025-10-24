import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';
import 'package:double_v_partners_test/features/users/data/models/country_model.dart';
import 'package:double_v_partners_test/features/users/domain/entities/country_entity.dart';

void main() {
  group('CountryModel', () {
    test('should be a subclass of Equatable', () {
      // Arrange
      const model = CountryModel(
        id: 'CO',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Assert
      expect(model, isA<Equatable>());
    });

    test('should create CountryModel from JSON', () {
      // Arrange
      final json = {'iso2': 'CO', 'name': 'Colombia', 'phone_code': '+57'};

      // Act
      final model = CountryModel.fromJson(json);

      // Assert
      expect(model.id, equals('CO'));
      expect(model.name, equals('Colombia'));
      expect(model.iso2, equals('CO'));
      expect(model.phoneCode, equals('+57'));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = <String, dynamic>{};

      // Act
      final model = CountryModel.fromJson(json);

      // Assert
      expect(model.id, equals(''));
      expect(model.name, equals(''));
      expect(model.iso2, equals(''));
      expect(model.phoneCode, equals(''));
    });

    test('should convert to JSON', () {
      // Arrange
      const model = CountryModel(
        id: 'CO',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['id'], equals('CO'));
      expect(json['name'], equals('Colombia'));
      expect(json['iso2'], equals('CO'));
      expect(json['phone_code'], equals('+57'));
    });

    test('should convert to domain entity', () {
      // Arrange
      const model = CountryModel(
        id: 'CO',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Act
      final entity = model.toDomain();

      // Assert
      expect(entity, isA<CountryEntity>());
      expect(entity.id, equals('CO'));
      expect(entity.name, equals('Colombia'));
      expect(entity.iso2, equals('CO'));
      expect(entity.phoneCode, equals('+57'));
    });

    test('should support equality', () {
      // Arrange
      const model1 = CountryModel(
        id: 'CO',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );
      const model2 = CountryModel(
        id: 'CO',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Assert
      expect(model1, equals(model2));
      expect(model1.hashCode, equals(model2.hashCode));
    });

    test('should support inequality', () {
      // Arrange
      const model1 = CountryModel(
        id: 'CO',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );
      const model2 = CountryModel(
        id: 'PE',
        name: 'Peru',
        iso2: 'PE',
        phoneCode: '+51',
      );

      // Assert
      expect(model1, isNot(equals(model2)));
    });

    test('should have correct string representation', () {
      // Arrange
      const model = CountryModel(
        id: 'CO',
        name: 'Colombia',
        iso2: 'CO',
        phoneCode: '+57',
      );

      // Act
      final stringRepresentation = model.toString();

      // Assert
      expect(stringRepresentation, contains('CountryModel'));
      expect(stringRepresentation, contains('CO'));
      expect(stringRepresentation, contains('Colombia'));
      expect(stringRepresentation, contains('+57'));
    });
  });
}
