import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../di/injection_container.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/create_user/create_user_bloc.dart';
import '../widgets/address_form_field.dart';

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'ES'),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addAddress() {
    showDialog(
      context: context,
      builder: (context) => AddressFormDialog(
        onSave: (address) {
          setState(() {
            _addresses.add(address);
          });
        },
      ),
    );
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
    final dateFormat = DateFormat('dd/MM/yyyy');

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
                        Text(
                          'Información Personal',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor ingresa el nombre';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _lastNameController,
                          decoration: const InputDecoration(
                            labelText: 'Apellido',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Por favor ingresa el apellido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Fecha de Nacimiento',
                              prefixIcon: Icon(Icons.cake_outlined),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            child: Text(
                              _selectedDate == null
                                  ? 'Selecciona una fecha'
                                  : dateFormat.format(_selectedDate!),
                              style: TextStyle(
                                color: _selectedDate == null
                                    ? Colors.grey[600]
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Direcciones',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            IconButton.filledTonal(
                              onPressed: _addAddress,
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (_addresses.isEmpty)
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.location_off_outlined,
                                    size: 48,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'No hay direcciones',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Agrega al menos una dirección',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ...List.generate(_addresses.length, (index) {
                            final address = _addresses[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).primaryColor,
                                  child: const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Text(address.municipality),
                                subtitle: Text(
                                  '${address.department}, ${address.country}',
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  onPressed: () => _removeAddress(index),
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }),
                        const SizedBox(height: 32),
                        Builder(
                          builder: (context) {
                            return FilledButton.icon(
                              onPressed: isSubmitting
                                  ? null
                                  : () => _submitForm(context),
                              icon: const Icon(Icons.save),
                              label: const Text('Crear Usuario'),
                              style: FilledButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                            );
                          },
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
