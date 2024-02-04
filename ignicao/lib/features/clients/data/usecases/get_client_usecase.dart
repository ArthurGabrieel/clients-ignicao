import 'package:dartz/dartz.dart';

import '../../../../shared/data/usecases/usecase.dart';
import '../../../../shared/errors/failures.dart';
import '../../domain/dto/get_client_dto.dart';
import '../../domain/entities/client_output.dart';
import '../../domain/repositories/client_repository.dart';

class GetClientUseCase implements UseCase<ClientOutputEntity?, GetClientDto> {
  GetClientUseCase(this.repository);

  final ClientRepository repository;

  @override
  Future<Either<Failure, ClientOutputEntity?>> call(GetClientDto params) async {
    return repository.getClient(params);
  }
}
