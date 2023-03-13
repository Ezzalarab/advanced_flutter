// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../data/failures/failure.dart';
import '../../data/requestes/login_request.dart';
import '../entities/auth.dart';
import '../repositories/repository.dart';
import 'base_uc.dart';

class LoginUC implements BaseUC<LoginUCInput, Auth> {
  final Repository _repository;
  LoginUC(
    this._repository,
  );

  @override
  Future<Either<Failure, Auth>> execute(LoginUCInput input) async {
    return await _repository
        .login(LoginRequest(email: input.email, password: input.password));
  }
}

class LoginUCInput {
  String email;
  String password;
  LoginUCInput({
    required this.email,
    required this.password,
  });
}
