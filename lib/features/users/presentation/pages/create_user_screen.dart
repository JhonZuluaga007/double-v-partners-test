import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/action_button.dart';
import '../../../../core/widgets/date_picker_field.dart';
import '../../../../core/widgets/form_field_widget.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/create_user/create_user_bloc.dart';
import '../widgets/address_list_widget.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _selectedDate;
  final List<AddressEntity> _addresses = [];

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _addAddressFromGeo() async {
    final result = await context.pushNamed(AppRouter.addressFormName);
    if (result != null && result is Map<String, String>) {
      final country = result['country'] ?? '';
      final state = result['state'] ?? '';
      final city = result['city'] ?? '';

      if (country.isNotEmpty && state.isNotEmpty && city.isNotEmpty) {
        final address = AddressEntity(
          country: country,
          department: state,
          municipality: city,
        );

        setState(() {
          _addresses.add(address);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Dirección agregada: $city, $state, $country'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  void _removeAddress(int index) {
    setState(() {
      _addresses.removeAt(index);
    });
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor selecciona la fecha de nacimiento'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      if (_addresses.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor agrega al menos una dirección'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final user = UserEntity(
        name: _nameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        birthDate: _selectedDate!,
        addresses: _addresses,
      );

      context.read<CreateUserBloc>().add(CreateUserEvent.submit(user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreateUserBloc>(),
      child: BlocListener<CreateUserBloc, CreateUserState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            submitting: () {},
            success: (user) {
              debugPrint('✅ Usuario creado, navegando de vuelta...');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Usuario creado exitosamente'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
              context.pop(true);
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: $message'),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 5),
                  action: SnackBarAction(
                    label: 'OK',
                    textColor: Colors.white,
                    onPressed: () {},
                  ),
                ),
              );
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Crear Usuario')),
          body: BlocBuilder<CreateUserBloc, CreateUserState>(
            builder: (context, state) {
              final isSubmitting = state.maybeWhen(
                submitting: () => true,
                orElse: () => false,
              );

              return Stack(
                children: [
                  Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        SectionHeader(
                          title: 'Información Personal',
                          icon: Icons.person_outline,
                        ),
                        const SizedBox(height: 16),
                        FormFieldWidget(
                          controller: _nameController,
                          label: 'Nombre',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor ingresa el nombre';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        FormFieldWidget(
                          controller: _lastNameController,
                          label: 'Apellido',
                          prefixIcon: Icons.person_outline,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor ingresa el apellido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DatePickerField(
                          selectedDate: _selectedDate,
                          onDateSelected: _onDateSelected,
                          label: 'Fecha de Nacimiento',
                        ),
                        const SizedBox(height: 32),
                        SectionHeader(
                          title: 'Direcciones',
                          icon: Icons.location_on_outlined,
                          action: IconButton.filledTonal(
                            onPressed: _addAddressFromGeo,
                            icon: const Icon(Icons.public),
                            tooltip: 'Seleccionar ubicación geográfica',
                          ),
                        ),
                        const SizedBox(height: 8),
                        AddressListWidget(
                          addresses: _addresses,
                          onAdd: _addAddressFromGeo,
                          onDelete: (index) => _removeAddress(index),
                          showActions: true,
                        ),
                        const SizedBox(height: 32),
                        ActionButton.create(
                          isEnabled: !isSubmitting,
                          onPressed: isSubmitting
                              ? null
                              : () => _submitForm(context),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  if (isSubmitting)
                    Container(
                      color: Colors.black26,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
