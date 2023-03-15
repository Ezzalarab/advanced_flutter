// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:advanced_flutter/domain/usecases/login_uc.dart';
import 'package:advanced_flutter/presentation/base/base_vm.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_class.dart';

class LoginVM extends BaseVM with LoginVMInputs, LoginVMOutputs {
  final StreamController _emailSC = StreamController<String>.broadcast();
  final StreamController _passwordSC = StreamController<String>.broadcast();
  final StreamController _areInputsValidSC =
      StreamController<String>.broadcast();

  LoginObject loginObject = LoginObject("", "");

  final LoginUC _loginUC;

  LoginVM(this._loginUC);

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _emailSC.close();
    _passwordSC.close();
    _areInputsValidSC.close();
  }

  // Inputs
  //

  @override
  setEmail(String email) {
    inputEmail.add(email);
    areInputValid.add(null);
    loginObject.copyWith(email: email);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    areInputValid.add(null);
    loginObject.copyWith(password: password);
  }

  @override
  Sink get inputEmail => _emailSC.sink;

  @override
  Sink get inputPassword => _passwordSC.sink;

  @override
  Sink get areInputValid => _areInputsValidSC.sink;

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
  Sink get inputAreInputsValid => _areInputsValidSC.sink;

  // Outputs
  //

  @override
  Stream<bool> get outEmailValid =>
      _emailSC.stream.map((userName) => _isEmailValid(userName));

  @override
  Stream<bool> get outIsPasswordValid =>
      _passwordSC.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outAreInputsValid =>
      _areInputsValidSC.stream.map((_) => _areInputsValid());

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _areInputsValid() {
    return _isEmailValid(loginObject.email) &&
        _isPasswordValid(loginObject.password);
  }
}

abstract class LoginVMInputs {
  setEmail(String email);
  setPassword(String password);
  login();
  Sink get inputEmail;
  Sink get inputPassword;
  Sink get inputAreInputsValid;
}

abstract class LoginVMOutputs {
  Stream<bool> get outEmailValid;
  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreInputsValid;
}
