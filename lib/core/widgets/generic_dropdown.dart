import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/users/presentation/bloc/address_form/address_form_bloc.dart';
import '../../features/users/presentation/bloc/address_form/address_form_state.dart';

/// A generic, reusable dropdown widget for geographic selection forms.
///
/// This widget provides a consistent dropdown interface that can be configured
/// for different types of data (countries, states, cities) while maintaining
/// the same behavior and styling across the application.
///
/// The widget handles common dropdown functionality including:
/// - Loading states with progress indicators
/// - Error states with user-friendly messages
/// - Disabled states with contextual information
/// - Consistent styling and layout
///
/// Example usage:
/// ```dart
/// GenericDropdown<CountryEntity>(
///   label: 'Country',
///   hint: 'Select your country',
///   getItems: (state) => state.countries,
///   getSelectedItem: (state) => state.selectedCountry,
///   isEnabled: (state) => true,
///   isLoading: (state) => state.isLoading,
///   hasError: (state) => state.hasError,
///   getErrorMessage: (state) => state.errorMessage,
///   loadingMessage: 'Loading countries...',
///   errorMessage: 'Error loading countries',
///   getItemName: (country) => country.name,
///   onItemSelected: (context, country) {
///     context.read<AddressFormBloc>().add(CountrySelected(country));
///   },
/// )
/// ```
class GenericDropdown<T> extends StatelessWidget {
  /// The label text displayed above the dropdown
  final String? label;

  /// The hint text displayed when no item is selected
  final String? hint;

  /// Callback triggered when a new item is selected
  final ValueChanged<T?>? onChanged;

  /// Function that extracts the list of available items from the state
  final List<T> Function(AddressFormState state) getItems;

  /// Function that extracts the currently selected item from the state
  final T? Function(AddressFormState state) getSelectedItem;

  /// Function that determines if the dropdown should be enabled
  final bool Function(AddressFormState state) isEnabled;

  /// Function that determines if the dropdown is in a loading state
  final bool Function(AddressFormState state) isLoading;

  /// Function that determines if the dropdown has an error state
  final bool Function(AddressFormState state) hasError;

  /// Function that extracts the error message from the state
  final String? Function(AddressFormState state) getErrorMessage;

  /// The message displayed during loading state
  final String loadingMessage;

  /// The default error message displayed when an error occurs
  final String errorMessage;

  /// The message displayed when the dropdown is disabled
  final String? disabledMessage;

  /// Function that extracts the display name from an item
  final String Function(T item) getItemName;

  /// Function called when an item is selected to trigger BLoC events
  final void Function(BuildContext context, T item) onItemSelected;

  /// Creates a new [GenericDropdown] instance.
  ///
  /// The [getItems], [getSelectedItem], [isEnabled], [isLoading], [hasError],
  /// [getErrorMessage], [loadingMessage], [errorMessage], [getItemName], and
  /// [onItemSelected] parameters are required to configure the dropdown's
  /// behavior and data binding.
  ///
  /// The [label], [hint], [onChanged], and [disabledMessage] parameters are
  /// optional and can be used to customize the dropdown's appearance and
  /// behavior.
  const GenericDropdown({
    super.key,
    this.label,
    this.hint,
    this.onChanged,
    required this.getItems,
    required this.getSelectedItem,
    required this.isEnabled,
    required this.isLoading,
    required this.hasError,
    required this.getErrorMessage,
    required this.loadingMessage,
    required this.errorMessage,
    this.disabledMessage,
    required this.getItemName,
    required this.onItemSelected,
  });

  /// Builds the dropdown widget with its associated states and behaviors.
  ///
  /// This method creates a [BlocBuilder] that listens to [AddressFormBloc]
  /// state changes and renders the appropriate dropdown interface based on
  /// the current state (loading, error, success, disabled).
  ///
  /// The widget automatically handles:
  /// - Rendering the dropdown with available items
  /// - Showing loading indicators when data is being fetched
  /// - Displaying error messages when data fetching fails
  /// - Providing disabled state feedback to users
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressFormBloc, AddressFormState>(
      builder: (context, state) {
        final items = getItems(state);
        final selectedItem = getSelectedItem(state);
        final enabled = isEnabled(state);
        final loading = isLoading(state);
        final hasErrorState = hasError(state);
        final errorMessageState = getErrorMessage(state);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label != null) ...[
              Text(
                label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: enabled ? null : Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
            ],
            DropdownButtonFormField<T>(
              key: ValueKey(selectedItem),
              initialValue: selectedItem,
              hint: Text(hint ?? 'Seleccione una opción'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                enabled: enabled,
              ),
              isDense: true,
              isExpanded: true,
              selectedItemBuilder: (BuildContext context) {
                return items.map<Widget>((T item) {
                  return Text(
                    getItemName(item),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  );
                }).toList();
              },
              items: items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    getItemName(item),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }).toList(),
              onChanged: enabled
                  ? (item) {
                      if (item != null) {
                        onItemSelected(context, item);
                        onChanged?.call(item);
                      }
                    }
                  : null,
            ),
            if (loading && items.isEmpty && enabled)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 8),
                    Text(loadingMessage),
                  ],
                ),
              ),
            if (hasErrorState && items.isEmpty && enabled)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  errorMessageState ?? errorMessage,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
            if (!enabled && disabledMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  disabledMessage!,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
