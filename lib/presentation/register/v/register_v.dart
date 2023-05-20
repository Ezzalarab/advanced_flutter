import 'dart:io';

import 'package:advanced_flutter/app/app_preferences.dart';
import 'package:advanced_flutter/app/di.dart';
import 'package:advanced_flutter/data/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/state_renderer/state_renderer_empl.dart';
import '../../register/vm/register_vm.dart';
import '../../resources/assets_manager.dart';
import '../../resources/colors_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class RegisterV extends StatefulWidget {
  const RegisterV({super.key});

  @override
  State<RegisterV> createState() => _RegisterVState();
}

class _RegisterVState extends State<RegisterV> {
  final RegisterVM _registerVM = gi<RegisterVM>();
  final _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences = gi<AppPreferences>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final ImagePicker _imagePicker = gi<ImagePicker>();
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
    _registerVM.setCountryCode(DataConstants.yemenCountryCode);
    _registerVM.isUserRegisteredSuccessfullySC.stream.listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setIsLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
      }
    });
  }

  _showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.camera),
                  title: const Text(AppStrings.photoGallery),
                  onTap: () {
                    _pickImageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.arrow_forward),
                  leading: const Icon(Icons.camera_alt_rounded),
                  title: const Text(AppStrings.camera),
                  onTap: () {
                    _pickImageFromCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        });
  }

  _pickImageFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _registerVM.setProfilePicture(File(image.path));
    } else {
      print("image is null");
    }
  }

  _pickImageFromCamera() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _registerVM.setProfilePicture(File(image.path));
    } else {
      print("image is null");
    }
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
                            _registerVM.setCountryCode(country.dialCode ??
                                DataConstants.yemenCountryCode);
                          },
                          initialSelection: '+967',
                          favorite: const ['+967', '+966', 'US'],
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
              SizedBox(height: spaceBetweenFields),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: StreamBuilder<bool>(
                  stream: _registerVM.outIsPasswordValid,
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        _showImagePicker(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.grey,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppSize.s8),
                          ),
                        ),
                        height: AppSize.s40,
                        child: _getMediaWidget(),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s30),
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
                        child: const Text(AppStrings.register),
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
                    AppStrings.alreadyHaveAccount,
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

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppPadding.p8,
        right: AppPadding.p8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(
            child: Text(
              AppStrings.profilePicture,
            ),
          ),
          Flexible(
            child: StreamBuilder(
              stream: _registerVM.outProfilePicture,
              builder: (context, snapshot) {
                return _pickedImage(snapshot.data);
              },
            ),
          ),
          const Flexible(
            child: Icon(
              Icons.add_a_photo_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pickedImage(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return const SizedBox();
    }
  }
}
