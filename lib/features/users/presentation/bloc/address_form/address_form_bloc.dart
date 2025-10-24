import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/geo_repository.dart';
import 'address_form_event.dart';
import 'address_form_state.dart';

class AddressFormBloc extends Bloc<AddressFormEvent, AddressFormState> {
  final GeoRepository geoRepository;

  AddressFormBloc({required this.geoRepository})
    : super(const AddressFormState()) {
    on<LoadCountries>(_onLoadCountries);
    on<CountrySelected>(_onCountrySelected);
    on<StateSelected>(_onStateSelected);
    on<CitySelected>(_onCitySelected);
    on<ResetForm>(_onResetForm);
  }

  Future<void> _onLoadCountries(
    LoadCountries event,
    Emitter<AddressFormState> emit,
  ) async {
    emit(state.copyWith(status: AddressFormStatus.loading));

    final result = await geoRepository.getCountries();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AddressFormStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (countries) => emit(
        state.copyWith(status: AddressFormStatus.success, countries: countries),
      ),
    );
  }

  Future<void> _onCountrySelected(
    CountrySelected event,
    Emitter<AddressFormState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AddressFormStatus.loading,
        selectedCountry: event.country,
        // Limpiar selecciones y listas hijas
        selectedState: null,
        selectedCity: null,
        states: [],
        cities: [],
      ),
    );

    final result = await geoRepository.getStatesByCountry(event.country.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AddressFormStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (states) => emit(
        state.copyWith(status: AddressFormStatus.success, states: states),
      ),
    );
  }

  Future<void> _onStateSelected(
    StateSelected event,
    Emitter<AddressFormState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AddressFormStatus.loading,
        selectedState: event.state,
        // Limpiar selección y lista hija
        selectedCity: null,
        cities: [],
      ),
    );

    final result = await geoRepository.getCitiesByState(event.state.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AddressFormStatus.error,
          errorMessage: failure.message,
        ),
      ),
      (cities) => emit(
        state.copyWith(status: AddressFormStatus.success, cities: cities),
      ),
    );
  }

  void _onCitySelected(CitySelected event, Emitter<AddressFormState> emit) {
    emit(state.copyWith(selectedCity: event.city));
  }

  void _onResetForm(ResetForm event, Emitter<AddressFormState> emit) {
    emit(const AddressFormState());
  }
}
