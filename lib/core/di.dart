import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import '../data/datasource/user_remote_datasource.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/repositories/user_repository.dart';
import '../domain/usecases/get_users_use_case.dart';
import '../presentation/providers/user_provider.dart';

final sl = GetIt.instance;

Future<void> init({required Box userBox}) async {
  if (!sl.isRegistered<Box>()) {
    sl.registerLazySingleton<Box>(() => userBox);
  }
  if (!sl.isRegistered<Dio>()) {
    sl.registerLazySingleton(() => Dio());
  }
  if (!sl.isRegistered<UserRemoteDataSource>()) {
    sl.registerLazySingleton<UserRemoteDataSource>(
          () => UserRemoteDataSourceImpl(dio: sl()),
    );
  }
  if (!sl.isRegistered<UserRepository>()) {
    sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(remoteDataSource: sl()),
    );
  }
  if (!sl.isRegistered<GetUsersUseCase>()) {
    sl.registerLazySingleton<GetUsersUseCase>(
          () => GetUsersUseCase(sl()),
    );
  }
  if (!sl.isRegistered<UserProvider>()) {
    sl.registerFactory(() => UserProvider(
      getUsersUseCase: sl(),
      userBox: sl<Box>(),
    ));
  }

}
