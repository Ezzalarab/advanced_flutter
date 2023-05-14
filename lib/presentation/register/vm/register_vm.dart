import 'dart:async';
import 'dart:io';

import 'package:advanced_flutter/domain/usecases/register_uc.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';

import '../../../domain/usecases/login_uc.dart';
import '../../base/base_vm.dart';
import '../../common/freezed_data_class.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_empl.dart';

class RegisterVM extends BaseVM with RegisterVMInputs, RegisterVMOutputs {
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
    // view model shold tell view content
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
  setEmail(String email) {
    inputEmail.add(email);
    registerObject = registerObject.copyWith(email: email);
    inputAreInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    registerObject = registerObject.copyWith(password: password);
    inputAreInputsValid.add(null);
  }

  @override
  Sink get inputEmail => _emailSC.sink;

  @override
  Sink get inputPassword => _passwordSC.sink;

  @override
  Sink get inputAreInputsValid => _areInputsValidSC.sink;

  @override
  login() async {
    inputState.add(
      LoadingState(
        stateRendererType: StateRendererType.popupLoadingState,
        message: "Logging in ...",
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
  Stream<bool> get userNameSC =>
      _userNameSC.stream.map((userName) => _isUserNameValie(userName));

  @override
  Stream<String?> get outputUserNameError => outputIsUserNameValid.map((isValid) => isValid? null : AppStrings.userNameShortMessage "User name should be at least 4 chars");

  @override
  Stream<bool> get outputIsUserNameValid => _userNameSC.stream.map((userName) => _isUserNameValid(userName));
  
  @override
  Stream<bool> get outIsPasswordValid =>
      _passwordSC.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get mobilNumberSC => throw UnimplementedError();

  @override
  Stream<bool> get profilePictureSC => throw UnimplementedError();
  
  @override
  // TODO: implement outputEmailError
  Stream<String?> get outputEmailError => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsProfilePictureValid
  Stream<bool> get outputIsProfilePictureValid => throw UnimplementedError();
  
  @override
  // TODO: implement outputIsUobilNumberValid
  Stream<bool> get outputIsUobilNumberValid => throw UnimplementedError();
  
  @override
  // TODO: implement outputMobileNumberError
  Stream<String?> get outputMobileNumberError => throw UnimplementedError();
  
  @override
  // TODO: implement outputPasswordError
  Stream<String?> get outputPasswordError => throw UnimplementedError();
  
}

// Private functions

bool _isUserNameValid(String userName) {
  return userName.isNotEmpty;
}

bool _isPasswordValid(String password) {
  return password.length > 4;
}

bool _isEmailValid(String email) {
  return email.isNotEmpty;
}

bool _areInputsValid() {
  return _isEmailValid(registerObject.email) &&
      _isPasswordValid(registerObject.password);
}

abstract class RegisterVMInputs {
  setEmail(String email);
  setPassword(String password);
  login();
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get userNameSC;
  Sink get mobilNumberSC;
  Sink get profilePictureSC;
  Sink get inputAreInputsValid;
}

abstract class RegisterVMOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputUserNameError;

  Stream<bool> get outputIsUobilNumberValid;
  Stream<String?> get outputMobileNumberError;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputEmailError;

  Stream<bool> get outIsPasswordValid;
  Stream<String?> get outputPasswordError;

  Stream<bool> get outputIsProfilePictureValid;
}
