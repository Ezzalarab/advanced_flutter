import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}
