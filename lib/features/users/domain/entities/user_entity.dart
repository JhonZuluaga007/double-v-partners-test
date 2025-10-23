import 'package:equatable/equatable.dart';
import 'address_entity.dart';

class UserEntity extends Equatable {
  final String? id;
  final String name;
  final String lastName;
  final DateTime birthDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<AddressEntity> addresses;

  const UserEntity({
    this.id,
    required this.name,
    required this.lastName,
    required this.birthDate,
    this.createdAt,
    this.updatedAt,
    required this.addresses,
  });

  String get fullName => '$name $lastName';

  @override
  List<Object?> get props => [
    id,
    name,
    lastName,
    birthDate,
    createdAt,
    updatedAt,
    addresses,
  ];

  @override
  String toString() =>
      'UserEntity(id: $id, name: $name, lastName: $lastName, birthDate: $birthDate, addresses: ${addresses.length})';
}
