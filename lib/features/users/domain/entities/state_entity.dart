import 'package:equatable/equatable.dart';

class StateEntity extends Equatable {
  final String id;
  final String name;
  final String countryId;

  const StateEntity({
    required this.id,
    required this.name,
    required this.countryId,
  });

  @override
  List<Object> get props => [id, name, countryId];

  @override
  String toString() =>
      'StateEntity(id: $id, name: $name, countryId: $countryId)';
}
