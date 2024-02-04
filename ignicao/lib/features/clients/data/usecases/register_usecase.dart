import 'package:dartz/dartz.dart';

import '../../../../shared/data/usecases/usecase.dart';
import '../../../../shared/errors/failures.dart';
import '../../domain/dto/register_dto.dart';
import '../../domain/entities/client_output.dart';
import '../../domain/repositories/client_repository.dart';

class RegisterUseCase implements UseCase<ClientOutputEntity, RegisterDto> {
  RegisterUseCase(this.repository);

  final ClientRepository repository;

  @override
  Future<Either<Failure, ClientOutputEntity>> call(RegisterDto params) async {
    return repository.registerClient(params);
  }
}
