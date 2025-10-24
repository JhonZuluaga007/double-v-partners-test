import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/country_entity.dart';
import '../bloc/address_form/address_form_bloc.dart';
import '../bloc/address_form/address_form_event.dart';
import '../../../../core/widgets/generic_dropdown.dart';

class CountryDropdown extends StatelessWidget {
  final String? label;
  final String? hint;
  final ValueChanged<CountryEntity?>? onChanged;

  const CountryDropdown({super.key, this.label, this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GenericDropdown<CountryEntity>(
      label: label,
      hint: hint ?? 'Seleccione un país',
      onChanged: onChanged,
      getItems: (state) => state.countries,
      getSelectedItem: (state) => state.selectedCountry,
      isEnabled: (state) => true,
      isLoading: (state) => state.isLoading && state.countries.isEmpty,
      hasError: (state) => state.hasError && state.countries.isEmpty,
      getErrorMessage: (state) => state.errorMessage,
      loadingMessage: 'Cargando países...',
      errorMessage: 'Error al cargar países',
      getItemName: (country) => country.name,
      onItemSelected: (context, country) {
        context.read<AddressFormBloc>().add(CountrySelected(country));
      },
    );
  }
}
