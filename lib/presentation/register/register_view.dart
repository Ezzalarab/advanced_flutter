import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../resources/values_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset("assets/json/loading.json"),
    ));
  }
}
