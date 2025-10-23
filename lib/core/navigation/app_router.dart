import 'package:go_router/go_router.dart';
import '../../features/users/presentation/pages/home_screen.dart';
import '../../features/users/presentation/pages/splash_screen.dart';

/// Configuración de rutas de la aplicación usando GoRouter
class AppRouter {
  static const String splash = '/';
  static const String home = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: home, builder: (context, state) => const HomeScreen()),
    ],
  );
}
