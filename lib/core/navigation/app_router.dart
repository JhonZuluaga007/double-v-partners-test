import 'package:go_router/go_router.dart';
import '../../features/users/presentation/pages/create_user_screen.dart';
import '../../features/users/presentation/pages/splash_screen.dart';
import '../../features/users/presentation/pages/user_detail_screen.dart';
import '../../features/users/presentation/pages/users_list_screen.dart';
import '../../features/users/presentation/pages/address_form_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String home = '/home';
  static const String createUser = '/create-user';
  static const String userDetail = '/user/:id';
  static const String addressForm = '/address-form';

  // Nombres de rutas para pushNamed
  static const String splashName = 'splash';
  static const String homeName = 'home';
  static const String createUserName = 'createUser';
  static const String userDetailName = 'userDetail';
  static const String addressFormName = 'addressForm';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const UsersListScreen(),
      ),
      GoRoute(
        path: createUser,
        name: 'createUser',
        builder: (context, state) => const CreateUserScreen(),
      ),
      GoRoute(
        path: userDetail,
        name: 'userDetail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return UserDetailScreen(userId: id);
        },
      ),
      GoRoute(
        path: addressForm,
        name: 'addressForm',
        builder: (context, state) => const AddressFormScreen(),
      ),
    ],
  );
}
