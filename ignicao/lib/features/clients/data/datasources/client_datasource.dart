import 'package:dio/dio.dart';

import '../../../../shared/errors/exceptions.dart';
import '../../../../shared/network/storage.dart';
import '../../../auth/data/dto/login_dto.dart';
import '../../domain/dto/delete_client_dto.dart';
import '../../domain/dto/get_client_dto.dart';
import '../../domain/dto/register_dto.dart';
import '../../domain/dto/search_client_dto.dart';
import '../../domain/dto/update_client_dto.dart';
import '../../domain/dto/update_password_dto.dart';
import '../models/client_output_model.dart';

abstract class ClientDataSource {
  Future<ClientOutputModel?> registerClient(RegisterDto params);
  Future<String?> loginClient(LoginDto params);
  Future<ClientOutputModel?> updateClient(UpdateClientDto params);
  Future<ClientOutputModel?> updatePassword(UpdatePasswordDto params);
  Future<ClientOutputModel?> getClient(GetClientDto params);
  Future<ClientOutputModel?> searchClient(SearchClientDto params);
  Future<List<ClientOutputModel>?> getClients();
  Future<void> deleteClient(DeleteClientDto params);
}

class ClientDataSourceImpl implements ClientDataSource {
  ClientDataSourceImpl({required this.dio, required this.secureStorage}) {
    dio.options.baseUrl = 'http://localhost:3000/clients';
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.headers['Content-Type'] = 'application/json';
  }

  final Dio dio;
  final SecureStorage secureStorage;

  Future<void> _setToken() async {
    final token = await secureStorage.getToken();
    if (token != null) {
      dio.options.headers['Authorization'] = token;
    } else {
      throw InvalidTokenException();
    }
  }

  Future<T?> _handleRequest<T>(Future<T> Function() request) async {
    try {
      await _setToken();
      return await request();
    } on InvalidTokenException {
      print('Error adding the token');
      rethrow;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        return null;
      }
      throw BadRequestException();
    }
  }

  @override
  Future<void> deleteClient(DeleteClientDto params) async {
    await _handleRequest(() async {
      final response = await dio.delete('/${params.id}');
      if (response.statusCode != 204) {
        throw BadRequestException();
      }
    });
  }

  @override
  Future<ClientOutputModel?> getClient(GetClientDto params) async {
    return _handleRequest(() async {
      final response = await dio.get('/${params.id}');
      if (response.statusCode == 200) {
        return ClientOutputModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw BadRequestException();
      }
    });
  }

  @override
  Future<ClientOutputModel?> searchClient(SearchClientDto params) async {
    return _handleRequest(() async {
      final response = await dio.get('/search/${params.email}');
      if (response.statusCode == 200) {
        return ClientOutputModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw BadRequestException();
      }
    });
  }

  @override
  Future<List<ClientOutputModel>?> getClients() async {
    return _handleRequest(() async {
      final response = await dio.get('/');
      if (response.statusCode == 200) {
        final clients = response.data as List;
        return clients
            .map((client) =>
                ClientOutputModel.fromJson(client as Map<String, dynamic>))
            .toList();
      } else {
        throw BadRequestException();
      }
    });
  }

  @override
  Future<String?> loginClient(LoginDto params) async {
    return _handleRequest(() async {
      final response = await dio.post('/login', data: params.toJson());
      if (response.statusCode == 200) {
        return response.data['accessToken'] as String;
      } else {
        throw BadRequestException();
      }
    });
  }

  @override
  Future<ClientOutputModel?> registerClient(RegisterDto params) async {
    return _handleRequest(() async {
      final response = await dio.post('/register', data: params.toJson());
      if (response.statusCode == 201) {
        return ClientOutputModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw BadRequestException();
      }
    });
  }

  @override
  Future<ClientOutputModel?> updateClient(UpdateClientDto params) async {
    return _handleRequest(() async {
      final response = await dio.put('/${params.id}', data: params.toJson());
      if (response.statusCode == 200) {
        return ClientOutputModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw BadRequestException();
      }
    });
  }

  @override
  Future<ClientOutputModel?> updatePassword(UpdatePasswordDto params) async {
    return _handleRequest(() async {
      final response = await dio.patch('/${params.id}', data: params.toJson());
      if (response.statusCode == 200) {
        return ClientOutputModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw BadRequestException();
      }
    });
  }
}
