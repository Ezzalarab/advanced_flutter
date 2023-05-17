import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/data/constants.dart';
import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_empl.dart';
import 'package:advanced_flutter/presentation/register/vm/register_vm.dart';
import 'package:advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:advanced_flutter/presentation/resources/colors_manager.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: const IconThemeData(
          color: ColorManager.primary,
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _registerVM.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context: context,
                contentScreenWidget: _getContentWidgt(),
                retryActionFunction: () {
                  _registerVM.register();
                },
              ) ??
              _getContentWidgt();
        },
      ),
    );
  }

  Widget _getContentWidgt() {
    double spaceBetweenFields = AppSize.s18;
    return Container(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: AppSize.s20),
              Center(
                child: SvgPicture.asset(
                  ImagesAssets.python,
                  height: 200,
                  width: 200,
                  color: ColorManager.primary,
                ),
              ),
              SizedBox(height: spaceBetweenFields),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _registerVM.outIsUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: AppStrings.userName,
                        labelText: AppStrings.userName,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.userNameShortMessage,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: spaceBetweenFields),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CountryCodePicker(
                          onChanged: (country) {
                            _registerVM.setCountryCode(
                                country.code ?? DataConstants.yemenCountryCode);
                          },
                          initialSelection: '+967',
                          favorite: const ['+966', '+1'],
                          showFlag: true,
                          showOnlyCountryWhenClosed: true,
                          hideMainText: true,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: StreamBuilder<bool>(
                          stream: _registerVM.outIsMobilNumberValid,
                          builder: (context, snapshot) {
                            return TextFormField(
                              controller: _mobileNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: AppStrings.mobileNumber,
                                labelText: AppStrings.mobileNumber,
                                errorText: (snapshot.data ?? true)
                                    ? null
                                    : AppStrings.mobileNotValidMessage,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: spaceBetweenFields),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _registerVM.outIsEmailValid,
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
              SizedBox(height: spaceBetweenFields),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _registerVM.outIsPasswordValid,
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
                  stream: _registerVM.outAreInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                        onPressed: snapshot.data ?? false
                            ? () {
                                _registerVM.register();
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
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      Routes.loginRoute,
                    );
                  },
                  child: Text(
                    AppStrings.notRegistered,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
