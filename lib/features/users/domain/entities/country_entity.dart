import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String id;
  final String name;
  final String iso2;
  final String phoneCode;

  const CountryEntity({
    required this.id,
    required this.name,
    required this.iso2,
    required this.phoneCode,
  });

  @override
  List<Object> get props => [id, name, iso2, phoneCode];

  @override
  String toString() =>
      'CountryEntity(id: $id, name: $name, iso2: $iso2, phoneCode: $phoneCode)';
}
