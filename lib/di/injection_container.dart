import 'package:get_it/get_it.dart';
import '../features/users/data/datasources/user_local_datasource.dart';
import '../features/users/data/datasources/user_remote_datasource.dart';
import '../features/users/data/repositories/user_repository_impl.dart';
import '../features/users/domain/repositories/user_repository.dart';
import '../features/users/domain/usecases/create_user_usecase.dart';
import '../features/users/domain/usecases/get_users_usecase.dart';
import '../features/users/presentation/bloc/user/user_bloc.dart';

final getIt = GetIt.instance;

/// Configura todas las dependencias de la aplicación
Future<void> configureDependencies() async {
  // Data Sources
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: getIt<UserRemoteDataSource>(),
      localDataSource: getIt<UserLocalDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetUsersUseCase(getIt<UserRepository>()));

  getIt.registerLazySingleton(() => CreateUserUseCase(getIt<UserRepository>()));

  // BLoCs
  getIt.registerFactory(
    () => UserBloc(
      getUsersUseCase: getIt<GetUsersUseCase>(),
      createUserUseCase: getIt<CreateUserUseCase>(),
    ),
  );
}
