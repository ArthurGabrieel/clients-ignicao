import 'package:dartz/dartz.dart';

import '../../../../shared/data/usecases/usecase.dart';
import '../../../../shared/errors/failures.dart';
import '../../domain/dto/delete_client_dto.dart';
import '../../domain/repositories/client_repository.dart';

class DeleteClientUseCase implements UseCase<void, DeleteClientDto> {
  DeleteClientUseCase(this.repository);

  final ClientRepository repository;

  @override
  Future<Either<Failure, void>> call(DeleteClientDto params) async {
    return repository.deleteClient(params);
  }
}
