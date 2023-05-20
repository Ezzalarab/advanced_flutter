import 'dart:async';
import 'dart:io';

import 'package:advanced_flutter/app/functions.dart';
import 'package:advanced_flutter/domain/usecases/register_uc.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';

import '../../base/base_vm.dart';
import '../../common/freezed_data_class.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_empl.dart';

class RegisterVM extends BaseVM with RegisterVMInputs, RegisterVMouts {
  final StreamController _userNameSC = StreamController<String>.broadcast();
  final StreamController _mobilNumberSC = StreamController<String>.broadcast();
  final StreamController _emailSC = StreamController<String>.broadcast();
  final StreamController _passwordSC = StreamController<String>.broadcast();
  final StreamController _profilePictureSC = StreamController<File>.broadcast();
  final StreamController _areInputsValidSC = StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullySC =
      StreamController<bool>();

  RegisterObject registerObject = RegisterObject("", "", "", "", "", "");

  final RegisterUC _registerUC;

  RegisterVM(this._registerUC);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _emailSC.close();
    _passwordSC.close();
    _areInputsValidSC.close();
    _userNameSC.close();
    _mobilNumberSC.close();
    _profilePictureSC.close();
    isUserLoggedInSuccessfullySC.close();
  }

  // Inputs
  //

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    registerObject = registerObject.copyWith(userName: userName);
    validate();
  }

  @override
  setCountryCode(String countryCode) {
    registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobilNumber.add(mobileNumber);
    registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    registerObject = registerObject.copyWith(email: email);
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    registerObject = registerObject.copyWith(password: password);
    validate();
  }

  @override
  setProfilePicture(File picture) {
    inputProfilePicture.add(picture);
    registerObject = registerObject.copyWith(profilePicture: picture.path);
    validate();
  }

  @override
  Sink get inputUserName => _userNameSC.sink;

  @override
  Sink get inputMobilNumber => _mobilNumberSC.sink;

  @override
  Sink get inputEmail => _emailSC.sink;

  @override
  Sink get inputPassword => _passwordSC.sink;

  @override
  Sink get inputProfilePicture => _profilePictureSC.sink;

  @override
  Sink get inputAreInputsValid => _areInputsValidSC.sink;

  @override
  register() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
        message: "Registering ...",
      ),
    );
    final requestResult = await _registerUC.execute(
      RegisterUCInput(
        userName: registerObject.userName,
        countryMobileCode: registerObject.countryMobileCode,
        mobileNumber: registerObject.mobileNumber,
        email: registerObject.email,
        password: registerObject.password,
        profilePicture: registerObject.profilePicture,
      ),
    );
    requestResult.fold(
      (failure) {
        inputState.add(
          ErrorState(
            stateRendererType: StateRendererType.popupErrorState,
            message: failure.message,
          ),
        );
      },
      (auth) {
        print("register success");
        // Content
        inputState.add(ContentState());
        // Navigate to main screen
        isUserLoggedInSuccessfullySC.add(true);
      },
    );
  }

  // Outputs
  //

  @override
  Stream<bool> get outIsUserNameValid =>
      _userNameSC.stream.map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outUserNameError => outIsUserNameValid
      .map((isValid) => isValid ? null : AppStrings.userNameShortMessage);

  @override
  Stream<bool> get outIsEmailValid =>
      _emailSC.stream.map((email) => isEmailValid(email));

  @override
  Stream<String?> get outEmailError => outIsEmailValid
      .map((isValid) => isValid ? null : AppStrings.emailNotValidMessage);

  @override
  Stream<bool> get outIsMobilNumberValid =>
      _mobilNumberSC.stream.map((number) => isMobileValid(number));

  @override
  Stream<String?> get outMobileNumberError => outIsMobilNumberValid
      .map((isValid) => isValid ? null : AppStrings.mobileNotValidMessage);

  @override
  Stream<bool> get outIsPasswordValid =>
      _passwordSC.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outPasswordError => outIsPasswordValid
      .map((isValid) => isValid ? null : AppStrings.mobileNotValidMessage);

  @override
  Stream<File> get outProfilePicture =>
      _profilePictureSC.stream.map((file) => file);

  @override
  Stream<bool> get outAreInputsValid =>
      _areInputsValidSC.stream.map((_) => _areInputsValid());

// Private functions

  bool _isUserNameValid(String userName) {
    return userName.length > 2;
  }

  bool _isPasswordValid(String password) {
    return password.length > 5;
  }

  bool _areInputsValid() {
    return registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  validate() {
    inputAreInputsValid.add(null);
  }
}

abstract class RegisterVMInputs {
  setUserName(String userName);
  setCountryCode(String countryCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
  setProfilePicture(File picture);
  register();
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputUserName;
  Sink get inputMobilNumber;
  Sink get inputProfilePicture;
  Sink get inputAreInputsValid;
}

abstract class RegisterVMouts {
  Stream<bool> get outIsUserNameValid;
  Stream<String?> get outUserNameError;

  Stream<bool> get outIsMobilNumberValid;
  Stream<String?> get outMobileNumberError;

  Stream<bool> get outIsEmailValid;
  Stream<String?> get outEmailError;

  Stream<bool> get outIsPasswordValid;
  Stream<String?> get outPasswordError;

  Stream<File> get outProfilePicture;

  Stream<bool> get outAreInputsValid;
}
