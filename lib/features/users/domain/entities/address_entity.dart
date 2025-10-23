import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? id;
  final String country;
  final String department;
  final String municipality;

  const AddressEntity({
    this.id,
    required this.country,
    required this.department,
    required this.municipality,
  });

  @override
  List<Object?> get props => [id, country, department, municipality];

  @override
  String toString() =>
      'AddressEntity(id: $id, country: $country, department: $department, municipality: $municipality)';
}
