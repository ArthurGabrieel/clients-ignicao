import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failures.dart';
import '../../../../shared/network/network_info.dart';
import '../../../auth/data/dto/login_dto.dart';
import '../../domain/dto/delete_client_dto.dart';
import '../../domain/dto/get_client_dto.dart';
import '../../domain/dto/register_dto.dart';
import '../../domain/dto/search_client_dto.dart';
import '../../domain/dto/update_client_dto.dart';
import '../../domain/dto/update_password_dto.dart';
import '../../domain/repositories/client_repository.dart';
import '../datasources/client_datasource.dart';
import '../models/client_output_model.dart';

class ClientRepositoryImpl implements ClientRepository {
  ClientRepositoryImpl({
    required this.clientDataSource,
    required this.networkInfo,
  });

  final ClientDataSource clientDataSource;
  final NetworkInfo networkInfo;

  Future<bool> get _isConnected => networkInfo.isConnected;

  Future<Either<Failure, T>> _execute<T>(Future<T> Function() function) async {
    if (await _isConnected) {
      try {
        final result = await function();
        return right(result);
      } on ServerFailure {
        return left(ServerFailure());
      }
    }
    return left(NoInternetConnectionFailure());
  }

  @override
  Future<Either<Failure, void>> deleteClient(DeleteClientDto params) async {
    return _execute(() => clientDataSource.deleteClient(params));
  }

  @override
  Future<Either<Failure, ClientOutputModel>> getClient(
      GetClientDto params) async {
    return _execute(() => clientDataSource.getClient(params));
  }

  @override
  Future<Either<Failure, ClientOutputModel>> searchClient(
      SearchClientDto params) async {
    return _execute(() => clientDataSource.searchClient(params));
  }

  @override
  Future<Either<Failure, List<ClientOutputModel>>> getClients() async {
    return _execute(() => clientDataSource.getClients());
  }

  @override
  Future<Either<Failure, String>> loginClient(LoginDto params) async {
    return _execute(() => clientDataSource.loginClient(params));
  }

  @override
  Future<Either<Failure, ClientOutputModel>> registerClient(
      RegisterDto params) async {
    return _execute(() => clientDataSource.registerClient(params));
  }

  @override
  Future<Either<Failure, ClientOutputModel>> updateClient(
      UpdateClientDto params) async {
    return _execute(() => clientDataSource.updateClient(params));
  }

  @override
  Future<Either<Failure, ClientOutputModel>> updatePassword(
      UpdatePasswordDto params) async {
    return _execute(() => clientDataSource.updatePassword(params));
  }
}
