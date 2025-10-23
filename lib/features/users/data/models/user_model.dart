import '../../../users/domain/entities/user_entity.dart';

/// Modelo de datos de usuario - capa de datos
/// Extiende la entidad y añade funcionalidad de serialización
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  /// Crea un UserModel desde JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  /// Convierte el UserModel a JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email};
  }

  /// Crea un UserModel desde una entidad
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(id: entity.id, name: entity.name, email: entity.email);
  }

  /// Copia el modelo con los cambios especificados
  UserModel copyWith({int? id, String? name, String? email}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
