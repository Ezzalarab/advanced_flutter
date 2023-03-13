// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:advanced_flutter/domain/usecases/login_uc.dart';
import 'package:advanced_flutter/presentation/base/base_vm.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_class.dart';

class LoginVM extends BaseVM with LoginVMInputs, LoginVMOutputs {
  final StreamController _emailSC = StreamController<String>.broadcast();
  final StreamController _passwordSC = StreamController<String>.broadcast();

  LoginObject loginObject = LoginObject("", "");

  final LoginUC _loginUC;

  LoginVM(this._loginUC);

  // Inputs
  //

  @override
  void start() {
    // TODO: implement start
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    loginObject.copyWith(email: email);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject.copyWith(password: password);
  }

  @override
  Sink get inputEmail => _emailSC.sink;

  @override
  Sink get inputPassword => _passwordSC.sink;

  @override
  login() async {
    loginObject;
    final requestResult = await _loginUC.execute(
        LoginUCInput(email: loginObject.email, password: loginObject.password));
    requestResult.fold(
      (failure) => {print(failure.message)},
      (auth) => {print(auth.customer!.name)},
    );
  }

  @override
  void dispose() {
    _emailSC.close();
    _passwordSC.close();
  }

  // Outputs
  //

  @override
  Stream<bool> get outEmailValid =>
      _emailSC.stream.map((userName) => _isUserNamedValid(userName));

  @override
  Stream<bool> get outIsPasswordValid =>
      _passwordSC.stream.map((password) => _isPasswordValid(password));

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNamedValid(String userName) {
    return userName.isNotEmpty;
  }
}

abstract class LoginVMInputs {
  setEmail(String email);
  setPassword(String password);
  login();
  Sink get inputEmail;
  Sink get inputPassword;
}

abstract class LoginVMOutputs {
  Stream<bool> get outEmailValid;
  Stream<bool> get outIsPasswordValid;
}
