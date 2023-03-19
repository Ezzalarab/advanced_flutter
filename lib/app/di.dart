import 'package:advanced_flutter/app/app_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final gi = GetIt.instance;

// Global Dependancies
Future<void> initAppModule() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  gi.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  gi.registerLazySingleton<AppPreferences>(
      () => AppPreferences(gi<SharedPreferences>()));
}

Future<void> initLoginModule() async {}
