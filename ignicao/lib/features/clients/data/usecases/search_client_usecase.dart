import 'package:dartz/dartz.dart';

import '../../../../shared/data/usecases/usecase.dart';
import '../../../../shared/errors/failures.dart';
import '../../domain/dto/search_client_dto.dart';
import '../../domain/entities/client_output.dart';
import '../../domain/repositories/client_repository.dart';

class SearchClientUseCase
    implements UseCase<ClientOutputEntity?, SearchClientDto> {
  SearchClientUseCase(this.repository);

  final ClientRepository repository;

  @override
  Future<Either<Failure, ClientOutputEntity?>> call(
      SearchClientDto params) async {
    return repository.searchClient(params);
  }
}
