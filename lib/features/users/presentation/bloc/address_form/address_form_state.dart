import 'package:equatable/equatable.dart';
import '../../../domain/entities/country_entity.dart';
import '../../../domain/entities/state_entity.dart';
import '../../../domain/entities/city_entity.dart';

enum AddressFormStatus { initial, loading, success, error }

class AddressFormState extends Equatable {
  final AddressFormStatus status;
  final String? errorMessage;

  // Las listas de opciones
  final List<CountryEntity> countries;
  final List<StateEntity> states;
  final List<CityEntity> cities;

  // Los valores seleccionados
  final CountryEntity? selectedCountry;
  final StateEntity? selectedState;
  final CityEntity? selectedCity;

  const AddressFormState({
    this.status = AddressFormStatus.initial,
    this.errorMessage,
    this.countries = const [],
    this.states = const [],
    this.cities = const [],
    this.selectedCountry,
    this.selectedState,
    this.selectedCity,
  });

  AddressFormState copyWith({
    AddressFormStatus? status,
    String? errorMessage,
    List<CountryEntity>? countries,
    List<StateEntity>? states,
    List<CityEntity>? cities,
    CountryEntity? selectedCountry,
    StateEntity? selectedState,
    CityEntity? selectedCity,
  }) {
    return AddressFormState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      countries: countries ?? this.countries,
      states: states ?? this.states,
      cities: cities ?? this.cities,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedState: selectedState ?? this.selectedState,
      selectedCity: selectedCity ?? this.selectedCity,
    );
  }

  bool get isLoading => status == AddressFormStatus.loading;
  bool get hasError => status == AddressFormStatus.error;
  bool get isSuccess => status == AddressFormStatus.success;

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    countries,
    states,
    cities,
    selectedCountry,
    selectedState,
    selectedCity,
  ];
}
