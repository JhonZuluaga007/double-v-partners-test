import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../di/injection_container.dart';
import '../bloc/user/user_bloc.dart';
import '../bloc/user/user_event.dart';
import '../bloc/user/user_state.dart';
import '../widgets/user_card.dart';

/// Pantalla que muestra la lista de usuarios
class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserBloc>()..add(const LoadUsersEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Usuarios'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context.read<UserBloc>().add(const LoadUsersEvent());
              },
            ),
          ],
        ),
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is UserOperationSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UsersLoaded) {
              if (state.users.isEmpty) {
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Crea tu primer usuario',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(const LoadUsersEvent());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    return UserCard(
                      user: user,
                      onTap: () {
                        context.push(
                          AppRouter.userDetail.replaceFirst(':id', user.id!),
                        );
                      },
                    );
                  },
                ),
              );
            }

            return Center(
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
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(AppRouter.createUser);
          },
          icon: const Icon(Icons.add),
          label: const Text('Crear Usuario'),
        ),
      ),
    );
  }
}
