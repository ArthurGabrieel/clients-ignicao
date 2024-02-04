import 'package:dartz/dartz.dart';

import '../../../../shared/data/usecases/usecase.dart';
import '../../../../shared/errors/failures.dart';
import '../../domain/dto/update_password_dto.dart';
import '../../domain/entities/client_output.dart';
import '../../domain/repositories/client_repository.dart';

class UpdatePasswordUseCase
    implements UseCase<ClientOutputEntity, UpdatePasswordDto> {
  UpdatePasswordUseCase(this.repository);

  final ClientRepository repository;

  @override
  Future<Either<Failure, ClientOutputEntity>> call(
      UpdatePasswordDto params) async {
    return repository.updatePassword(params);
  }
}
