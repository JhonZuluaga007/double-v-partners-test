import 'package:equatable/equatable.dart';
import '../../domain/entities/country_entity.dart';

class CountryModel extends Equatable {
  final String id;
  final String name;
  final String iso2;
  final String phoneCode;

  const CountryModel({
    required this.id,
    required this.name,
    required this.iso2,
    required this.phoneCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['iso2'] ?? '',
      name: json['name'] ?? '',
      iso2: json['iso2'] ?? '',
      phoneCode: json['phone_code'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'iso2': iso2, 'phone_code': phoneCode};
  }

  CountryEntity toDomain() {
    return CountryEntity(id: id, name: name, iso2: iso2, phoneCode: phoneCode);
  }

  @override
  List<Object> get props => [id, name, iso2, phoneCode];

  @override
  String toString() =>
      'CountryModel(id: $id, name: $name, iso2: $iso2, phoneCode: $phoneCode)';
}
