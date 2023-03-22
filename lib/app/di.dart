import 'package:advanced_flutter/app/app_preferences.dart';
import 'package:advanced_flutter/data/data_sources/local_ds.dart';
import 'package:advanced_flutter/data/data_sources/remote_ds.dart';
import 'package:advanced_flutter/data/network/app_api.dart';
import 'package:advanced_flutter/data/network/dio_factory.dart';
import 'package:advanced_flutter/data/network/network_info.dart';
import 'package:advanced_flutter/data/repositories/repository_impl.dart';
import 'package:advanced_flutter/domain/repositories/repository.dart';
import 'package:advanced_flutter/domain/usecases/login_uc.dart';
import 'package:advanced_flutter/presentation/login/vm/login_vm.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final gi = GetIt.instance;

// Global Dependancies //
Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  // AppPreference
  gi.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  gi.registerLazySingleton<AppPreferences>(
      () => AppPreferences(gi<SharedPreferences>()));

  // Network Info
  gi.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker()); // TODO check if there is problem
  gi.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(gi<InternetConnectionChecker>()));

  // Dio
  gi.registerLazySingleton<DioFactory>(() => DioFactory(gi<AppPreferences>()));
  Dio dio = await gi<DioFactory>().getDio();

  // App Service Client
  gi.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // Remote Data Source
  gi.registerLazySingleton<RemoteDS>(
      () => RemoteDSImpl(gi<AppServiceClient>()));

  // Local Data Source
  gi.registerLazySingleton<LocalDS>(() => LocalDSImpl());

  // Repository
  gi.registerLazySingleton<Repository>(() => RepositoryImpl(gi(), gi(), gi()));
}

Future<void> initLoginModule() async {
  if (!gi.isRegistered<LoginUC>()) {
    gi.registerFactory<LoginUC>(() => LoginUC(gi<Repository>()));
    gi.registerFactory<LoginVM>(() => LoginVM(gi<LoginUC>()));
  }
}
