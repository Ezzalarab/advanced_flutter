import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/presentation/register/vm/register_vm.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resources/values_manager.dart';

class RegisterV extends StatefulWidget {
  const RegisterV({super.key});

  @override
  State<RegisterV> createState() => _RegisterVState();
}

class _RegisterVState extends State<RegisterV> {
  final RegisterVM _registerVM = gi<RegisterVM>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _registerVM.start();
    _userNameController.addListener(() {
      _registerVM.setUserName(_userNameController.text);
    });
    _emailController.addListener(() {
      _registerVM.setEmail(_emailController.text);
    });
    _passwordController.addListener(() {
      _registerVM.setPassword(_passwordController.text);
    });
    _mobileNumberController.addListener(() {
      _registerVM.setMobileNumber(_mobileNumberController.text);
    });
  }

  @override
  void dispose() {
    _registerVM.dispose();
    super.dispose();
  }

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
