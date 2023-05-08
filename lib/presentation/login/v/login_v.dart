import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_empl.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
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
  final LoginVM _loginVM = gi<LoginVM>();
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
    _loginVM.isUserLoggedInSuccessfullySC.stream.listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _loginVM.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context: context,
                contentScreenWidget: _getContent(),
                retryActionFunction: () => _loginVM.login(),
              ) ??
              _getContent();
        },
      ),
    );
  }

  Widget _getContent() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: AppSize.s100),
              Center(
                child: SvgPicture.asset(
                  ImagesAssets.python,
                  height: 200,
                  width: 200,
                  color: ColorManager.primary,
                ),
              ),
              const SizedBox(height: AppSize.s20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _loginVM.outEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppStrings.email,
                        labelText: AppStrings.email,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.emailError,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _loginVM.outIsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: AppStrings.password,
                        labelText: AppStrings.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.passwordError,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _loginVM.outAreAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: snapshot.data ?? false
                            ? () {
                                _loginVM.login();
                              }
                            : null,
                        child: const Text(AppStrings.login),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.forgotPasswordRoute);
                      },
                      child: Text(
                        AppStrings.forgitPassword,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.registerRoute);
                      },
                      child: Text(
                        AppStrings.notRegistered,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              )
            ],
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
