import 'package:uuid/uuid.dart';

class ClientInputEntity {
  ClientInputEntity({
    String? id,
    required this.name,
    required this.email,
    required this.password,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  final String id;
  final String name;
  final String email;
  final String password;
  final DateTime createdAt;
}
