class UpdatePasswordDto {
  UpdatePasswordDto({
    required this.id,
    required this.oldPassword,
    required this.password,
  });

  final String id;
  final String oldPassword;
  final String password;

  Map<String, String> toJson() {
    return {
      'id': id,
      'oldPassword': oldPassword,
      'password': password,
    };
  }
}
