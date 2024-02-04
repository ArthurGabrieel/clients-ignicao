import '../../domain/entities/client_output.dart';

class ClientOutputModel extends ClientOutputEntity {
  ClientOutputModel({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
  });

  factory ClientOutputModel.fromJson(Map<String, dynamic> json) {
    return ClientOutputModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}
