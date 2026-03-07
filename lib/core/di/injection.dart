import 'package:easilybecho/core/data/network/network_info.dart';
import 'package:easilybecho/views/features/auth/bloc/auth_bloc.dart';
import 'package:easilybecho/views/features/auth/repo/auth_repo.dart';
import 'package:easilybecho/views/features/auth/repo/auth_repo_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // ─── Network ───────────────────────────────────────────────────────────────
  getIt.registerLazySingleton(() => InternetConnection());
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // ─── Repo ──────────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());

  // ─── Bloc ─────────────────────────────────────────────────────────────────
  getIt.registerFactory(() => AuthBloc(authRepo: getIt<AuthRepo>()));
}
