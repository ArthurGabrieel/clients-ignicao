import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/auth/data/usecases/login_usecase.dart';
import 'features/clients/data/datasources/client_datasource.dart';
import 'features/clients/data/repositories/client_repository_impl.dart';
import 'features/clients/data/usecases/delete_client_usecase.dart';
import 'features/clients/data/usecases/get_all_clients_usecase.dart';
import 'features/clients/data/usecases/get_client_usecase.dart';
import 'features/clients/data/usecases/register_usecase.dart';
import 'features/clients/data/usecases/search_client_usecase.dart';
import 'features/clients/data/usecases/update_client_usecase.dart';
import 'features/clients/data/usecases/update_password_usecase.dart';
import 'features/clients/domain/repositories/client_repository.dart';
import 'features/clients/presentation/bloc/clients_bloc.dart';
import 'shared/network/network_info.dart';
import 'shared/network/storage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ClientsBloc());

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetAllClientUseCase(sl()));
  sl.registerLazySingleton(() => GetClientUseCase(sl()));
  sl.registerLazySingleton(() => SearchClientUseCase(sl()));
  sl.registerLazySingleton(() => UpdateClientUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePasswordUseCase(sl()));
  sl.registerLazySingleton(() => DeleteClientUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<ClientRepository>(() => ClientRepositoryImpl(
        clientDataSource: sl(),
        networkInfo: sl(),
      ));

  // Data sources`
  sl.registerLazySingleton<ClientDataSource>(
    () => ClientDataSourceImpl(dio: sl(), secureStorage: sl()),
  );

  // Shared
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl(sl()));

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
}
