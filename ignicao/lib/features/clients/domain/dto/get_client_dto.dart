class GetClientDto {
  GetClientDto({required this.id});

  final String id;

  Map<String, String> toJson() {
    return {
      'id': id,
    };
  }
}