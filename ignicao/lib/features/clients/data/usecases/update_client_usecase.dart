import 'package:dartz/dartz.dart';

import '../../../../shared/data/usecases/usecase.dart';
import '../../../../shared/errors/failures.dart';
import '../../domain/dto/update_client_dto.dart';
import '../../domain/entities/client_output.dart';
import '../../domain/repositories/client_repository.dart';

class UpdateClientUseCase
    implements UseCase<ClientOutputEntity?, UpdateClientDto> {
  UpdateClientUseCase(this.repository);

  final ClientRepository repository;

  @override
  Future<Either<Failure, ClientOutputEntity?>> call(
      UpdateClientDto params) async {
    return repository.updateClient(params);
  }
}
