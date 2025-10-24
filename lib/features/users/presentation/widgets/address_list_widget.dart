import 'package:flutter/material.dart';
import '../../domain/entities/address_entity.dart';
import 'address_list_item.dart';

class AddressListWidget extends StatelessWidget {
  final List<AddressEntity> addresses;
  final VoidCallback? onAdd;
  final Function(int)? onEdit;
  final Function(int)? onDelete;
  final bool showActions;

  const AddressListWidget({
    super.key,
    required this.addresses,
    this.onAdd,
    this.onEdit,
    this.onDelete,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context) {
    if (addresses.isEmpty) {
      return Card(
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
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        ...List.generate(addresses.length, (index) {
          final address = addresses[index];
          return AddressListItem(
            address: address,
            onEdit: onEdit != null ? () => onEdit!(index) : null,
            onDelete: onDelete != null ? () => onDelete!(index) : null,
            showActions: showActions,
          );
        }),
      ],
    );
  }
}
