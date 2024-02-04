import 'package:dartz/dartz.dart';

import '../../errors/failures.dart';

abstract class UseCase<Type, Dto> {
  Future<Either<Failure, Type?>> call(Dto params);
}

class NoParams {}
