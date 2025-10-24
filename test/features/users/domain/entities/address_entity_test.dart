import 'package:flutter_test/flutter_test.dart';
import 'package:double_v_partners_test/features/users/domain/entities/address_entity.dart';

void main() {
  group('AddressEntity', () {
    const tAddress = AddressEntity(
      id: 'addr1',
      country: 'Colombia',
      department: 'Antioquia',
      municipality: 'Medellín',
    );

    test('should be a subclass of Equatable', () {
      expect(tAddress, isA<AddressEntity>());
    });

    test('should have correct properties', () {
      expect(tAddress.id, 'addr1');
      expect(tAddress.country, 'Colombia');
      expect(tAddress.department, 'Antioquia');
      expect(tAddress.municipality, 'Medellín');
    });

    test('should support equality', () {
      const address1 = AddressEntity(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      );
      const address2 = AddressEntity(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      );

      expect(address1, equals(address2));
      expect(address1.hashCode, equals(address2.hashCode));
    });

    test('should support inequality', () {
      const address1 = AddressEntity(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      );
      const address2 = AddressEntity(
        id: 'addr2',
        country: 'México',
        department: 'Jalisco',
        municipality: 'Guadalajara',
      );

      expect(address1, isNot(equals(address2)));
      expect(address1.hashCode, isNot(equals(address2.hashCode)));
    });

    test('should support null id', () {
      const address = AddressEntity(
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      );

      expect(address.id, isNull);
      expect(address.country, 'Colombia');
      expect(address.department, 'Antioquia');
      expect(address.municipality, 'Medellín');
    });

    test('should create copy with updated values', () {
      const updatedAddress = AddressEntity(
        id: 'addr1',
        country: 'México',
        department: 'Jalisco',
        municipality: 'Guadalajara',
      );

      expect(updatedAddress.id, 'addr1');
      expect(updatedAddress.country, 'México');
      expect(updatedAddress.department, 'Jalisco');
      expect(updatedAddress.municipality, 'Guadalajara');
    });

    test('should have correct string representation', () {
      const address = AddressEntity(
        id: 'addr1',
        country: 'Colombia',
        department: 'Antioquia',
        municipality: 'Medellín',
      );

      expect(address.toString(), contains('addr1'));
      expect(address.toString(), contains('Colombia'));
      expect(address.toString(), contains('Antioquia'));
      expect(address.toString(), contains('Medellín'));
    });
  });
}
