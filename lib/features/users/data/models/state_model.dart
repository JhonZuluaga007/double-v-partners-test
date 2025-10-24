import 'package:equatable/equatable.dart';
import '../../domain/entities/state_entity.dart';

class StateModel extends Equatable {
  final String id;
  final String name;
  final String countryId;

  const StateModel({
    required this.id,
    required this.name,
    required this.countryId,
  });

  factory StateModel.fromJson(Map<String, dynamic> json, String countryId) {
    return StateModel(
      id: '${countryId}_${json['name']}',
      name: json['name'] ?? '',
      countryId: countryId,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'country_id': countryId};
  }

  StateEntity toDomain() {
    return StateEntity(id: id, name: name, countryId: countryId);
  }

  @override
  List<Object> get props => [id, name, countryId];

  @override
  String toString() =>
      'StateModel(id: $id, name: $name, countryId: $countryId)';
}
