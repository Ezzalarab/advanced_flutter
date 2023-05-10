import 'dart:async';

import '../../../domain/usecases/login_uc.dart';
import '../../base/base_vm.dart';
import '../../common/freezed_data_class.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_empl.dart';

class LoginVM extends BaseVM with LoginVMInputs, LoginVMOutputs {
  final StreamController _emailSC = StreamController<String>.broadcast();
  final StreamController _passwordSC = StreamController<String>.broadcast();
  final StreamController _areInputsValidSC = StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullySC =
      StreamController<bool>();

  LoginObject loginObject = LoginObject("", "");

  final LoginUC _loginUC;

  LoginVM(this._loginUC);

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
    isUserLoggedInSuccessfullySC.close();
  }

  // Inputs
  //

  @override
  setEmail(String email) {
    inputEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
    inputAreInputsValid.add(null);
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
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
    final requestResult = await _loginUC.execute(
      LoginUCInput(
        email: loginObject.email,
        password: loginObject.password,
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
  Stream<bool> get outEmailValid =>
      _emailSC.stream.map((email) => _isEmailValid(email));

  @override
  Stream<bool> get outIsPasswordValid =>
      _passwordSC.stream.map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outAreAllInputsValid =>
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
  Stream<bool> get outAreAllInputsValid;
}
