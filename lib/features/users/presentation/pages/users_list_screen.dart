import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../di/injection_container.dart';
import '../bloc/users_list/users_list_bloc.dart';
import '../widgets/user_card.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<UsersListBloc>()..add(const UsersListEvent.load()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Usuarios'),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    context.read<UsersListBloc>().add(
                      const UsersListEvent.refresh(),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<UsersListBloc, UsersListState>(
          builder: (context, state) {
            return state.when(
              initial: () => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, size: 80, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Carga los usuarios',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (users) {
                if (users.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay usuarios',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Crea tu primer usuario',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  );
                }

                return Builder(
                  builder: (context) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<UsersListBloc>().add(
                          const UsersListEvent.refresh(),
                        );
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return UserCard(
                            user: user,
                            onTap: user.id != null
                                ? () {
                                    context.push(
                                      AppRouter.userDetail.replaceFirst(
                                        ':id',
                                        user.id!,
                                      ),
                                    );
                                  }
                                : null,
                          );
                        },
                      ),
                    );
                  },
                );
              },
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar usuarios',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Builder(
                      builder: (context) {
                        return FilledButton.icon(
                          onPressed: () {
                            context.read<UsersListBloc>().add(
                              const UsersListEvent.load(),
                            );
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reintentar'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton.extended(
              onPressed: () async {
                debugPrint('🔄 Navegando a crear usuario...');
                final result = await context.push(AppRouter.createUser);
                debugPrint('🔄 Resultado: $result');
                if (result == true && context.mounted) {
                  debugPrint('🔄 Refrescando lista de usuarios...');
                  context.read<UsersListBloc>().add(
                    const UsersListEvent.refresh(),
                  );
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Crear Usuario'),
            );
          },
        ),
      ),
    );
  }
}
