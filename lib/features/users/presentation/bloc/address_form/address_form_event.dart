import 'package:equatable/equatable.dart';
import '../../../domain/entities/country_entity.dart';
import '../../../domain/entities/state_entity.dart';
import '../../../domain/entities/city_entity.dart';

abstract class AddressFormEvent extends Equatable {
  const AddressFormEvent();

  @override
  List<Object?> get props => [];
}

class LoadCountries extends AddressFormEvent {
  const LoadCountries();
}

class CountrySelected extends AddressFormEvent {
  final CountryEntity country;

  const CountrySelected(this.country);

  @override
  List<Object> get props => [country];
}

class StateSelected extends AddressFormEvent {
  final StateEntity state;

  const StateSelected(this.state);

  @override
  List<Object> get props => [state];
}

class CitySelected extends AddressFormEvent {
  final CityEntity city;

  const CitySelected(this.city);

  @override
  List<Object> get props => [city];
}

class ResetForm extends AddressFormEvent {
  const ResetForm();
}
