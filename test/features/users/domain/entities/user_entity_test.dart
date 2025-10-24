import 'package:flutter_test/flutter_test.dart';
import 'package:double_v_partners_test/features/users/domain/entities/address_entity.dart';
import 'package:double_v_partners_test/features/users/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    const tAddresses = [
      AddressEntity(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      ),
      AddressEntity(
        id: 'addr2',
        country: 'México',
        department: 'Jalisco',
        municipality: 'Guadalajara',
      ),
    ];

    final tUser = UserEntity(
      id: '1',
      name: 'John',
      lastName: 'Doe',
      birthDate: DateTime(1990, 1, 1),
      addresses: tAddresses,
      createdAt: DateTime(2023, 1, 1),
      updatedAt: DateTime(2023, 1, 2),
    );

    test('should be a subclass of Equatable', () {
      expect(tUser, isA<UserEntity>());
    });

    test('should have correct properties', () {
      expect(tUser.id, '1');
      expect(tUser.name, 'John');
      expect(tUser.lastName, 'Doe');
      expect(tUser.birthDate, DateTime(1990, 1, 1));
      expect(tUser.addresses, tAddresses);
      expect(tUser.createdAt, DateTime(2023, 1, 1));
      expect(tUser.updatedAt, DateTime(2023, 1, 2));
    });

    test('should have correct fullName property', () {
      expect(tUser.fullName, 'John Doe');
    });

    test('should support equality', () {
      final user1 = UserEntity(
        id: '1',
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: tAddresses,
      );
      final user2 = UserEntity(
        id: '1',
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: tAddresses,
      );

      expect(user1, equals(user2));
      expect(user1.hashCode, equals(user2.hashCode));
    });

    test('should support inequality', () {
      final user1 = UserEntity(
        id: '1',
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: tAddresses,
      );
      final user2 = UserEntity(
        id: '2',
        name: 'Jane',
        lastName: 'Smith',
        birthDate: DateTime(1995, 5, 15),
        addresses: const [],
      );

      expect(user1, isNot(equals(user2)));
      expect(user1.hashCode, isNot(equals(user2.hashCode)));
    });

    test('should support null optional properties', () {
      final user = UserEntity(
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: const [],
      );

      expect(user.id, isNull);
      expect(user.createdAt, isNull);
      expect(user.updatedAt, isNull);
      expect(user.name, 'John');
      expect(user.lastName, 'Doe');
      expect(user.birthDate, DateTime(1990, 1, 1));
      expect(user.addresses, isEmpty);
    });

    test('should handle empty addresses list', () {
      final user = UserEntity(
        id: '1',
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: const [],
      );

      expect(user.addresses, isEmpty);
      expect(user.fullName, 'John Doe');
    });

    test('should handle single address', () {
      const singleAddress = [
        AddressEntity(
          country: 'Colombia',
          department: 'Antioquia',
          municipality: 'Medellín',
        ),
      ];

      final user = UserEntity(
        id: '1',
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: singleAddress,
      );

      expect(user.addresses.length, 1);
      expect(user.addresses.first.country, 'Colombia');
    });

    test('should have correct string representation', () {
      final user = UserEntity(
        id: '1',
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: tAddresses,
      );

      expect(user.toString(), contains('1'));
      expect(user.toString(), contains('John'));
      expect(user.toString(), contains('Doe'));
      expect(user.toString(), contains('1990-01-01'));
    });

    test('should handle different date formats', () {
      final user1 = UserEntity(
        name: 'John',
        lastName: 'Doe',
        birthDate: DateTime(1990, 1, 1),
        addresses: const [],
      );
      final user2 = UserEntity(
        name: 'Jane',
        lastName: 'Smith',
        birthDate: DateTime(1995, 5, 15, 12, 30, 45),
        addresses: const [],
      );

      expect(user1.birthDate, DateTime(1990, 1, 1));
      expect(user2.birthDate, DateTime(1995, 5, 15, 12, 30, 45));
    });
  });
}
