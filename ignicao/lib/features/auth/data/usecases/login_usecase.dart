import 'package:dartz/dartz.dart';

import '../../../../shared/data/usecases/usecase.dart';
import '../../../../shared/errors/failures.dart';
import '../../../clients/domain/repositories/client_repository.dart';
import '../dto/login_dto.dart';

class LoginUseCase implements UseCase<String, LoginDto> {
  LoginUseCase(this.repository);

  final ClientRepository repository;

  @override
  Future<Either<Failure, String>> call(LoginDto params) async {
    return repository.loginClient(params);
  }
}
