import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    super.id,
    required super.country,
    required super.department,
    required super.municipality,
  });

  /// Crea un AddressModel desde JSON
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String?,
      country: json['country'] as String,
      department: json['department'] as String,
      municipality: json['municipality'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'country': country,
      'department': department,
      'municipality': municipality,
    };

    if (id != null) {
      json['id'] = id;
    }

    return json;
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      id: entity.id,
      country: entity.country,
      department: entity.department,
      municipality: entity.municipality,
    );
  }
}
