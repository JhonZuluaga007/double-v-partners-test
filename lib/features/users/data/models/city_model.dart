import 'package:equatable/equatable.dart';
import '../../domain/entities/city_entity.dart';

class CityModel extends Equatable {
  final String id;
  final String name;
  final String stateId;

  const CityModel({
    required this.id,
    required this.name,
    required this.stateId,
  });

  factory CityModel.fromJson(Map<String, dynamic> json, String stateId) {
    return CityModel(
      id: '${stateId}_${json['name']}',
      name: json['name'] ?? '',
      stateId: stateId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'state_id': stateId};
  }

  CityEntity toDomain() {
    return CityEntity(id: id, name: name, stateId: stateId);
  }

  @override
  List<Object> get props => [id, name, stateId];

  @override
  String toString() => 'CityModel(id: $id, name: $name, stateId: $stateId)';
}
