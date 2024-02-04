class UpdateClientDto {
  UpdateClientDto({
    required this.id,
    required this.name,
    required this.email,
  });

  final String id;
  final String name;
  final String email;

  Map<String, String> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
