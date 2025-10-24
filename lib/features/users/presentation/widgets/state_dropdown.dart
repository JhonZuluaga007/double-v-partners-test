import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/state_entity.dart';
import '../bloc/address_form/address_form_bloc.dart';
import '../bloc/address_form/address_form_event.dart';
import '../../../../core/widgets/generic_dropdown.dart';

class StateDropdown extends StatelessWidget {
  final String? label;
  final String? hint;
  final ValueChanged<StateEntity?>? onChanged;

  const StateDropdown({super.key, this.label, this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GenericDropdown<StateEntity>(
      label: label,
      hint: hint ?? 'Seleccione un departamento',
      onChanged: onChanged,
      getItems: (state) => state.states,
      getSelectedItem: (state) => state.selectedState,
      isEnabled: (state) => state.selectedCountry != null,
      isLoading: (state) =>
          state.isLoading &&
          state.states.isEmpty &&
          state.selectedCountry != null,
      hasError: (state) =>
          state.hasError &&
          state.states.isEmpty &&
          state.selectedCountry != null,
      getErrorMessage: (state) => state.errorMessage,
      loadingMessage: 'Cargando departamentos...',
      errorMessage: 'Error al cargar departamentos',
      disabledMessage: 'Primero seleccione un país',
      getItemName: (state) => state.name,
      onItemSelected: (context, state) {
        context.read<AddressFormBloc>().add(StateSelected(state));
      },
    );
  }
}
