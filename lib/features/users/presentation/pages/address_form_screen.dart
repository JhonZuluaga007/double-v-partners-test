import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/action_button.dart';
import '../../../../di/injection_container.dart';
import '../bloc/address_form/address_form_bloc.dart';
import '../bloc/address_form/address_form_event.dart';
import '../bloc/address_form/address_form_state.dart';
import '../widgets/country_dropdown.dart';
import '../widgets/state_dropdown.dart';
import '../widgets/city_dropdown.dart';

class AddressFormScreen extends StatelessWidget {
  final Function(String country, String state, String city)? onAddressSelected;

  const AddressFormScreen({super.key, this.onAddressSelected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddressFormBloc>()..add(const LoadCountries()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Seleccionar Dirección')),
        body: BlocBuilder<AddressFormBloc, AddressFormState>(
          builder: (context, state) {
            if (state.isLoading && state.countries.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Cargando datos geográficos...'),
                  ],
                ),
              );
            }

            if (state.hasError && state.countries.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar datos',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.errorMessage ?? 'Error desconocido',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AddressFormBloc>().add(
                          const LoadCountries(),
                        );
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  _buildCountrySection(context),
                  const SizedBox(height: 20),
                  _buildStateSection(context),
                  const SizedBox(height: 20),
                  _buildCitySection(context),
                  const SizedBox(height: 32),
                  _buildSelectionInfo(context),
                  const SizedBox(height: 32),
                  _buildConfirmButton(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seleccione su ubicación',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Complete los campos para seleccionar su país, departamento y municipio.',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildCountrySection(BuildContext context) {
    return CountryDropdown(
      label: 'País',
      hint: 'Seleccione su país',
      onChanged: (country) {},
    );
  }

  Widget _buildStateSection(BuildContext context) {
    return StateDropdown(
      label: 'Departamento',
      hint: 'Seleccione su departamento',
      onChanged: (state) {},
    );
  }

  Widget _buildCitySection(BuildContext context) {
    return CityDropdown(
      label: 'Municipio',
      hint: 'Seleccione su municipio',
      onChanged: (city) {},
    );
  }

  Widget _buildSelectionInfo(BuildContext context) {
    return BlocBuilder<AddressFormBloc, AddressFormState>(
      builder: (context, state) {
        if (state.selectedCountry != null ||
            state.selectedState != null ||
            state.selectedCity != null) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selección actual:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                if (state.selectedCountry != null)
                  Text('País: ${state.selectedCountry!.name}'),
                if (state.selectedState != null)
                  Text('Departamento: ${state.selectedState!.name}'),
                if (state.selectedCity != null)
                  Text('Municipio: ${state.selectedCity!.name}'),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return BlocBuilder<AddressFormBloc, AddressFormState>(
      builder: (context, state) {
        final isFormComplete =
            state.selectedCountry != null &&
            state.selectedState != null &&
            state.selectedCity != null;

        return ActionButton.selection(
          isEnabled: isFormComplete,
          onPressed: isFormComplete
              ? () {
                  if (onAddressSelected != null) {
                    onAddressSelected!(
                      state.selectedCountry!.name,
                      state.selectedState!.name,
                      state.selectedCity!.name,
                    );
                  }
                  Navigator.of(context).pop({
                    'country': state.selectedCountry!.name,
                    'state': state.selectedState!.name,
                    'city': state.selectedCity!.name,
                  });
                }
              : null,
        );
      },
    );
  }
}
