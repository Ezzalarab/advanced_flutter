import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/values_manager.dart';

class RegisterV extends StatefulWidget {
  const RegisterV({super.key});

  @override
  State<RegisterV> createState() => _RegisterVState();
}

class _RegisterVState extends State<RegisterV> {
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
