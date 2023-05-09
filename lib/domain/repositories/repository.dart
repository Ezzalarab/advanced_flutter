import 'package:dartz/dartz.dart';

import '../../data/failures/failure.dart';
import '../entities/auth.dart';
import '../../data/requestes/login_request.dart';

abstract class Repository {
  Future<Either<Failure, Auth>> login(
    LoginRequest loginRequest,
  );
  Future<Either<Failure, Auth>> forgotPassword(
    String email,
  );
}
