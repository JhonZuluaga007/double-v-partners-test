import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../../../../core/widgets/error_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
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
              initial: () => const EmptyStateWidget(
                icon: Icons.info_outline,
                title: 'Carga los usuarios',
              ),
              loading: () => const LoadingWidget(),
              loaded: (users) {
                if (users.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.people_outline,
                    title: 'No hay usuarios',
                    subtitle: 'Crea tu primer usuario',
                    onAction: () async {
                      final result = await context.push(AppRouter.createUser);
                      if (result == true && context.mounted) {
                        context.read<UsersListBloc>().add(
                          const UsersListEvent.refresh(),
                        );
                      }
                    },
                    actionText: 'Crear Usuario',
                    actionIcon: Icons.add,
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
              error: (message) => CustomErrorWidget(
                message: message,
                onRetry: () {
                  context.read<UsersListBloc>().add(
                    const UsersListEvent.load(),
                  );
                },
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
