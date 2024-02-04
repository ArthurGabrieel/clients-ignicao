class RegisterDto {
  RegisterDto({
    required this.name,
    required this.email,
    required this.password,
  });
  final String name;
  final String email;
  final String password;

  Map<String, String> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
