import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ignicao/features/clients/data/usecases/update_client_usecase.dart';
import 'package:ignicao/features/clients/domain/dto/update_client_dto.dart';
import 'package:ignicao/features/clients/domain/repositories/client_repository.dart';
import 'package:ignicao/shared/errors/failures.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/clients/client_factory.dart';

class MockClientRepository extends Mock implements ClientRepository {}

void main() {
  late UpdateClientUseCase sut;
  late MockClientRepository mockClientRepository;

  final tClientInput = clientInputFactory();
  final tDto = UpdateClientDto(
    id: tClientInput.id,
    name: tClientInput.name,
    email: tClientInput.email,
  );

  final tClientOutput = clientOutputFactory();

  setUp(() {
    mockClientRepository = MockClientRepository();
    sut = UpdateClientUseCase(mockClientRepository);
  });

  setUpAll(() {
    registerFallbackValue(UpdateClientDto(
      id: tDto.id,
      name: tDto.name,
      email: tDto.email,
    ));
  });

  test('Should get client from the repository', () async {
    // Arrange
    when(() => mockClientRepository.updateClient(any()))
        .thenAnswer((_) async => Right(tClientOutput));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Right(tClientOutput));
    verify(() => mockClientRepository.updateClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });

  test('Should return a failure when dont succeed', () async {
    // Arrange
    when(() => mockClientRepository.updateClient(any()))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => mockClientRepository.updateClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });
}
