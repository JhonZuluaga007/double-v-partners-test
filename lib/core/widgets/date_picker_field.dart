import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;
  final String label;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.label,
    this.firstDate,
    this.lastDate,
    this.initialDate,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime(2000),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      locale: const Locale('es', 'ES'),
    );

    if (picked != null && picked != selectedDate) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');

    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.cake_outlined),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          selectedDate == null
              ? 'Selecciona una fecha'
              : dateFormat.format(selectedDate!),
          style: TextStyle(
            color: selectedDate == null ? Colors.grey[600] : null,
          ),
        ),
      ),
    );
  }
}
