import 'package:advanced_flutter/data/constants.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/di.dart';
import '../../common/state_renderer/state_renderer_empl.dart';
import '../../resources/strings_manager.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/values_manager.dart';
import '../vm/forgot_password_vm.dart';

class ForgotPasswordV extends StatefulWidget {
  const ForgotPasswordV({super.key});

  @override
  State<ForgotPasswordV> createState() => _ForgotPasswordVState();
}

class _ForgotPasswordVState extends State<ForgotPasswordV> {
  final ForgotPasswordVM _forgotPasswordVM = gi<ForgotPasswordVM>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _forgotPasswordVM.start();
    _emailController
        .addListener(() => _forgotPasswordVM.setEmail(_emailController.text));
    _forgotPasswordVM.isPasswordResetLinkSent.stream.listen((supportMessage) {
      print("Password Reset Link Sent Success");
      SchedulerBinding.instance.addPostFrameCallback((_) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _forgotPasswordVM.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context: context,
                contentScreenWidget: _getContent(),
                retryActionFunction: () => _forgotPasswordVM.forgotPassword(),
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
              const SizedBox(height: AppSize.s60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _forgotPasswordVM.outEmailValid,
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
              const SizedBox(height: AppSize.s60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _forgotPasswordVM.outEmailValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: snapshot.data ?? false
                            ? () {
                                _forgotPasswordVM.forgotPassword();
                              }
                            : null,
                        child: const Text(AppStrings.submit),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _forgotPasswordVM.dispose();
    super.dispose();
  }
}
