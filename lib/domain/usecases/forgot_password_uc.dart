import 'package:dartz/dartz.dart';

import '../../data/failures/failure.dart';
import '../entities/auth.dart';
import '../repositories/repository.dart';
import 'base_uc.dart';

class ForgotPasswordUC implements BaseUC<String, Auth> {
  final Repository _repository;
  ForgotPasswordUC(this._repository);

  @override
  Future<Either<Failure, Auth>> execute(String email) async {
    return await _repository.forgotPassword(email);
  }
}
