import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failures.dart';
import '../../../auth/data/dto/login_dto.dart';
import '../dto/delete_client_dto.dart';
import '../dto/get_client_dto.dart';
import '../dto/register_dto.dart';
import '../dto/search_client_dto.dart';
import '../dto/update_client_dto.dart';
import '../dto/update_password_dto.dart';
import '../entities/client_output.dart';

abstract class ClientRepository {
  Future<Either<Failure, ClientOutputEntity>> registerClient(
      RegisterDto params);

  Future<Either<Failure, String>> loginClient(LoginDto params);

  Future<Either<Failure, ClientOutputEntity>> updateClient(
      UpdateClientDto params);

  Future<Either<Failure, ClientOutputEntity>> updatePassword(
      UpdatePasswordDto params);

  Future<Either<Failure, ClientOutputEntity>> getClient(GetClientDto params);

  Future<Either<Failure, ClientOutputEntity>> searchClient(
      SearchClientDto params);

  Future<Either<Failure, List<ClientOutputEntity>>> getClients();

  Future<Either<Failure, void>> deleteClient(DeleteClientDto params);
}
