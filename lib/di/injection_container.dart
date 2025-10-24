import 'package:get_it/get_it.dart';
import '../core/network/api_client.dart';
import '../features/users/data/datasources/user_api_datasource.dart';
import '../features/users/data/datasources/geo_local_datasource.dart';
import '../features/users/data/repositories/user_repository_impl.dart';
import '../features/users/data/repositories/geo_repository_impl.dart';
import '../features/users/domain/repositories/user_repository.dart';
import '../features/users/domain/repositories/geo_repository.dart';
import '../features/users/domain/usecases/create_user_usecase.dart';
import '../features/users/domain/usecases/get_user_by_id_usecase.dart';
import '../features/users/domain/usecases/get_users_usecase.dart';
import '../features/users/presentation/bloc/create_user/create_user_bloc.dart';
import '../features/users/presentation/bloc/user_detail/user_detail_bloc.dart';
import '../features/users/presentation/bloc/users_list/users_list_bloc.dart';
import '../features/users/presentation/bloc/address_form/address_form_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  getIt.registerLazySingleton<UserApiDataSource>(
    () => UserApiDataSourceImpl(apiClient: getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(apiDataSource: getIt<UserApiDataSource>()),
  );

  // Geo dependencies
  getIt.registerLazySingleton<GeoLocalDataSource>(
    () => GeoLocalDataSourceImpl(),
  );

  getIt.registerLazySingleton<GeoRepository>(
    () => GeoRepositoryImpl(localDataSource: getIt<GeoLocalDataSource>()),
  );

  getIt.registerLazySingleton(() => GetUsersUseCase(getIt<UserRepository>()));

  getIt.registerLazySingleton(
    () => GetUserByIdUseCase(getIt<UserRepository>()),
  );

  getIt.registerLazySingleton(() => CreateUserUseCase(getIt<UserRepository>()));

  getIt.registerFactory(
    () => UsersListBloc(getUsersUseCase: getIt<GetUsersUseCase>()),
  );

  getIt.registerFactory(
    () => CreateUserBloc(createUserUseCase: getIt<CreateUserUseCase>()),
  );

  getIt.registerFactory(
    () => UserDetailBloc(getUserByIdUseCase: getIt<GetUserByIdUseCase>()),
  );

  getIt.registerFactory(
    () => AddressFormBloc(geoRepository: getIt<GeoRepository>()),
  );
}
