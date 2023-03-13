import 'dart:async';

import 'package:advanced_flutter/presentation/base/base_vm.dart';

class LoginVM extends BaseVM with LoginVMInputs, LoginVMOutputs {
  final StreamController _userNameSC = StreamController<String>.broadcast();
  final StreamController _passwordSC = StreamController<String>.broadcast();

  // Inputs
  //

  @override
  void start() {
    // TODO: implement start
  }

  @override
  setUserName(String username) {
    inputUserName.add(username);
  }

  @override
  setUserPassword(String password) {
    inputPassword.add(password);
  }

  @override
  Sink get inputUserName => _userNameSC.sink;

  @override
  Sink get inputPassword => _passwordSC.sink;

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _userNameSC.close();
    _passwordSC.close();
  }

  // Outputs
  //

  @override
  Stream<bool> get outIsUserNameValid =>
      _userNameSC.stream.map((userName) => _isUserNamedValid(userName));

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
  setUserName(String username);
  setUserPassword(String password);
  login();
  Sink get inputUserName;
  Sink get inputPassword;
}

abstract class LoginVMOutputs {
  Stream<bool> get outIsUserNameValid;
  Stream<bool> get outIsPasswordValid;
}
