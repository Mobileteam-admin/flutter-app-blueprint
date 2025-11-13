import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/login_bloc.dart';
import '../../features/splash/presentation/bloc/splash_bloc.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../network/http_service.dart';
import '../connectivity/connectivity_cubit.dart';
import '../storage/shared_prefs.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());

  // Core services
  sl.registerLazySingleton(() => SharedPrefManager());
  sl.registerLazySingleton(() => HttpService.internal());
  sl.registerLazySingleton(() => ConnectivityCubit(connectivity: sl()));

  // Features - auth
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: sl(), prefs: sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remote: sl(), prefs: sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));

  // Splash & Home blocs
  sl.registerFactory(() => SplashBloc(prefs: sl()));
  sl.registerFactory(() => HomeBloc(httpService: sl(), prefs: sl()));
}
