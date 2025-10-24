import '../../domain/entities/user_entity.dart';
import 'address_model.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    required super.name,
    required super.lastName,
    required super.birthDate,
    super.createdAt,
    super.updatedAt,
    required super.addresses,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? json['UserID']) as String?,
      name: json['name'] as String,
      lastName: json['last_name'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      addresses: (json['addresses'] as List<dynamic>)
          .map(
            (address) => AddressModel.fromJson(address as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'name': name,
      'last_name': lastName,
      'birth_date': birthDate.toIso8601String(),
      'addresses': addresses
          .map((address) => AddressModel.fromEntity(address).toJson())
          .toList(),
    };

    if (id != null) json['id'] = id;
    if (createdAt != null) json['created_at'] = createdAt!.toIso8601String();
    if (updatedAt != null) json['updated_at'] = updatedAt!.toIso8601String();

    return json;
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      lastName: entity.lastName,
      birthDate: entity.birthDate,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      addresses: entity.addresses
          .map((address) => AddressModel.fromEntity(address))
          .toList(),
    );
  }
}
