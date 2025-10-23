import 'package:go_router/go_router.dart';
import '../../features/users/presentation/pages/create_user_screen.dart';
import '../../features/users/presentation/pages/splash_screen.dart';
import '../../features/users/presentation/pages/user_detail_screen.dart';
import '../../features/users/presentation/pages/users_list_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String createUser = '/create-user';
  static const String userDetail = '/user/:id';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: home, builder: (context, state) => const UsersListScreen()),
      GoRoute(
        path: createUser,
        builder: (context, state) => const CreateUserScreen(),
      ),
      GoRoute(
        path: userDetail,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return UserDetailScreen(userId: id);
        },
      ),
    ],
  );
}
