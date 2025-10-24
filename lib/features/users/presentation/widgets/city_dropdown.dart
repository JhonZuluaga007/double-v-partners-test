import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/city_entity.dart';
import '../bloc/address_form/address_form_bloc.dart';
import '../bloc/address_form/address_form_event.dart';
import '../../../../core/widgets/generic_dropdown.dart';

class CityDropdown extends StatelessWidget {
  final String? label;
  final String? hint;
  final ValueChanged<CityEntity?>? onChanged;

  const CityDropdown({super.key, this.label, this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GenericDropdown<CityEntity>(
      label: label,
      hint: hint ?? 'Seleccione un municipio',
      onChanged: onChanged,
      getItems: (state) => state.cities,
      getSelectedItem: (state) => state.selectedCity,
      isEnabled: (state) => state.selectedState != null,
      isLoading: (state) =>
          state.isLoading &&
          state.cities.isEmpty &&
          state.selectedState != null,
      hasError: (state) =>
          state.hasError && state.cities.isEmpty && state.selectedState != null,
      getErrorMessage: (state) => state.errorMessage,
      loadingMessage: 'Cargando municipios...',
      errorMessage: 'Error al cargar municipios',
      disabledMessage: 'Primero seleccione un departamento',
      getItemName: (city) => city.name,
      onItemSelected: (context, city) {
        context.read<AddressFormBloc>().add(CitySelected(city));
      },
    );
  }
}
