import 'package:dartz/dartz.dart';

import '../../data/failures/failure.dart';
import '../repositories/repository.dart';
import 'base_uc.dart';

class ForgotPasswordUC implements BaseUC<String, String> {
  final Repository _repository;
  ForgotPasswordUC(this._repository);

  @override
  Future<Either<Failure, String>> execute(String email) async {
    return await _repository.forgotPassword(email);
  }
}
