import 'package:flutter/material.dart';
import '../../domain/entities/address_entity.dart';

class AddressFormDialog extends StatefulWidget {
  final AddressEntity? initialAddress;
  final Function(AddressEntity) onSave;

  const AddressFormDialog({
    super.key,
    this.initialAddress,
    required this.onSave,
  });

  @override
  State<AddressFormDialog> createState() => _AddressFormDialogState();
}

class _AddressFormDialogState extends State<AddressFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _countryController;
  late final TextEditingController _departmentController;
  late final TextEditingController _municipalityController;

  @override
  void initState() {
    super.initState();
    _countryController = TextEditingController(
      text: widget.initialAddress?.country ?? '',
    );
    _departmentController = TextEditingController(
      text: widget.initialAddress?.department ?? '',
    );
    _municipalityController = TextEditingController(
      text: widget.initialAddress?.municipality ?? '',
    );
  }

  @override
  void dispose() {
    _countryController.dispose();
    _departmentController.dispose();
    _municipalityController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final address = AddressEntity(
        id: widget.initialAddress?.id,
        country: _countryController.text.trim(),
        department: _departmentController.text.trim(),
        municipality: _municipalityController.text.trim(),
      );

      widget.onSave(address);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.initialAddress == null
            ? 'Agregar Dirección'
            : 'Editar Dirección',
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                  labelText: 'País',
                  prefixIcon: Icon(Icons.public),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el país';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(
                  labelText: 'Departamento',
                  prefixIcon: Icon(Icons.map),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el departamento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _municipalityController,
                decoration: const InputDecoration(
                  labelText: 'Municipio',
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el municipio';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Guardar')),
      ],
    );
  }
}
