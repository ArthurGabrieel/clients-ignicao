import 'package:dartz/dartz.dart';

import '../../../../shared/data/usecases/usecase.dart';
import '../../../../shared/errors/failures.dart';
import '../../domain/entities/client_output.dart';
import '../../domain/repositories/client_repository.dart';

class GetAllClientUseCase
    implements UseCase<List<ClientOutputEntity>, NoParams> {
  GetAllClientUseCase(this.repository);
  final ClientRepository repository;

  @override
  Future<Either<Failure, List<ClientOutputEntity>>> call(
      NoParams params) async {
    return repository.getClients();
  }
}
