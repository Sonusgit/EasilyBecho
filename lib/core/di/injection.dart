import 'package:easilybecho/core/network/dio_client.dart';
import 'package:easilybecho/core/network/network_info.dart';
import 'package:easilybecho/core/network/services/api_service.dart';
import 'package:easilybecho/views/features/auth/repo/login_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Network
  getIt.registerLazySingleton(() => InternetConnection());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  // Dio
  getIt.registerLazySingleton(() => DioClient());

  // API Service
  getIt.registerLazySingleton(
    () => ApiService(dioClient: getIt(), networkInfo: getIt()),
  );
  // Repositories
  getIt.registerLazySingleton(() => AuthRepository());
}
