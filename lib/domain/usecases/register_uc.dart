// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../data/failures/failure.dart';
import '../../data/requestes/login_request.dart';
import '../entities/auth.dart';
import '../repositories/repository.dart';
import 'base_uc.dart';

class RegisterUC implements BaseUC<RegisterUCInput, Auth> {
  final Repository _repository;
  RegisterUC(this._repository);

  @override
  Future<Either<Failure, Auth>> execute(RegisterUCInput input) async {
    return await _repository.register(RegisterRequest(
      userName: input.userName,
      countryMobileCode: input.countryMobileCode,
      mobileNumber: input.mobileNumber,
      email: input.email,
      password: input.password,
      profilePicture: input.profilePicture,
    ));
  }
}

class RegisterUCInput {
  String userName;
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUCInput({
    required this.userName,
    required this.countryMobileCode,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.profilePicture,
  });
}
