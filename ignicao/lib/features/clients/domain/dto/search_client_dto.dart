class SearchClientDto {
  SearchClientDto(this.email);

  final String email;

  Map<String, String> toJson() {
    return {
      'email': email,
    };
  }
}
