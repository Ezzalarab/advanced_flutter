import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/values_manager.dart';
import '../vm/login_vm.dart';

class LoginV extends StatefulWidget {
  const LoginV({super.key});

  @override
  State<LoginV> createState() => _LoginVState();
}

class _LoginVState extends State<LoginV> {
  final LoginVM _loginVM = LoginVM(_loginUC);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _loginVM.start();
    _emailController
        .addListener(() => _loginVM.setEmail(_emailController.text));
    _passwordController
        .addListener(() => _loginVM.setPassword(_passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  Widget _getContent() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  ImagesAssets.python,
                  height: 200,
                  width: 200,
                  color: ColorManager.primary,
                ),
                const SizedBox(height: AppSize.s20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
                  child: StreamBuilder<bool>(
                    builder: (context, snapshot) => TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginVM.dispose();
    super.dispose();
  }
}
