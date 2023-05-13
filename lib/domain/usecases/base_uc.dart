import '../../data/failures/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUC<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
