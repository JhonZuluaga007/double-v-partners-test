import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String id;
  final String name;
  final String stateId;

  const CityEntity({
    required this.id,
    required this.name,
    required this.stateId,
  });

  @override
  List<Object> get props => [id, name, stateId];

  @override
  String toString() => 'CityEntity(id: $id, name: $name, stateId: $stateId)';
}
