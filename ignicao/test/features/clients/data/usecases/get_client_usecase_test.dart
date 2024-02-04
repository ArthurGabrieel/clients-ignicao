import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ignicao/features/clients/data/usecases/get_client_usecase.dart';
import 'package:ignicao/features/clients/domain/dto/get_client_dto.dart';
import 'package:ignicao/features/clients/domain/repositories/client_repository.dart';
import 'package:ignicao/shared/errors/failures.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/clients/client_factory.dart';

class MockClientRepository extends Mock implements ClientRepository {}

void main() {
  late GetClientUseCase sut;
  late MockClientRepository mockClientRepository;

  final tClient = clientOutputFactory();
  final tDto = GetClientDto(id: tClient.id);

  setUp(() {
    mockClientRepository = MockClientRepository();
    sut = GetClientUseCase(mockClientRepository);
  });

  setUpAll(() {
    registerFallbackValue(GetClientDto(id: tDto.id));
  });

  test('Should get client from the repository', () async {
    // Arrange
    when(() => mockClientRepository.getClient(any()))
        .thenAnswer((_) async => Right(tClient));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Right(tClient));
    verify(() => mockClientRepository.getClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });

  test('Should return a failure when dont succeed', () async {
    // Arrange
    when(() => mockClientRepository.getClient(any()))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => mockClientRepository.getClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });
}
