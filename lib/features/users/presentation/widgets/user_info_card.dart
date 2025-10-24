import 'package:flutter/material.dart';
import '../../domain/entities/user_entity.dart';

class UserInfoCard extends StatelessWidget {
  final UserEntity user;
  final List<Widget> additionalFields;

  const UserInfoCard({
    super.key,
    required this.user,
    this.additionalFields = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _InfoRow(icon: Icons.person, label: 'Nombre', value: user.name),
            const Divider(),
            _InfoRow(
              icon: Icons.person_outline,
              label: 'Apellido',
              value: user.lastName,
            ),
            const Divider(),
            _InfoRow(
              icon: Icons.cake_outlined,
              label: 'Fecha de Nacimiento',
              value: _formatDate(user.birthDate),
            ),
            ...additionalFields,
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(value, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
