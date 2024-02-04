import '../../domain/entities/client_input.dart';

class ClientInputModel extends ClientInputEntity {
  ClientInputModel({
    required super.id,
    required super.name,
    required super.email,
    required super.password,
    required super.createdAt,
  });

  factory ClientInputModel.fromJson(Map<String, dynamic> json) {
    return ClientInputModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'name': super.name,
      'email': super.email,
      'password': super.password,
      'createdAt': super.createdAt.toIso8601String(),
    };
  }
}
