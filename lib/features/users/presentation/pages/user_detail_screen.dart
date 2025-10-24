import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../di/injection_container.dart';
import '../bloc/user_detail/user_detail_bloc.dart';
import '../widgets/address_list_widget.dart';
import '../widgets/user_avatar.dart';
import '../widgets/user_info_card.dart';

class UserDetailScreen extends StatelessWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final dateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');

    return BlocProvider(
      create: (context) =>
          getIt<UserDetailBloc>()..add(UserDetailEvent.load(userId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Detalle del Usuario')),
        body: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox(),
              loading: () => const LoadingWidget(),
              loaded: (user) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            UserAvatar(
                              user: user,
                              radius: 60,
                              heroTag: 'user-avatar-$userId',
                            ),
                            const SizedBox(height: 16),
                            Text(
                              user.fullName,
                              style: Theme.of(context).textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            if (user.id != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  'ID: ${user.id!.substring(0, 8)}...',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      SectionHeader(
                        title: 'Información Personal',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 12),
                      UserInfoCard(
                        user: user,
                        additionalFields: [
                          if (user.createdAt != null) ...[
                            const Divider(),
                            _InfoRow(
                              icon: Icons.schedule,
                              label: 'Fecha de Creación',
                              value: dateTimeFormat.format(user.createdAt!),
                            ),
                          ],
                          if (user.updatedAt != null) ...[
                            const Divider(),
                            _InfoRow(
                              icon: Icons.update,
                              label: 'Última Actualización',
                              value: dateTimeFormat.format(user.updatedAt!),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: 'Direcciones (${user.addresses.length})',
                        icon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: 12),
                      AddressListWidget(addresses: user.addresses),
                    ],
                  ),
                );
              },
              error: (message) => CustomErrorWidget(
                message: message,
                onRetry: () {
                  context.read<UserDetailBloc>().add(
                    const UserDetailEvent.refresh(),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
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
