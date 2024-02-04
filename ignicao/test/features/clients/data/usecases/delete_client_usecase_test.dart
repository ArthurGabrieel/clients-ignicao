import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ignicao/features/clients/data/usecases/delete_client_usecase.dart';
import 'package:ignicao/features/clients/domain/dto/delete_client_dto.dart';
import 'package:ignicao/features/clients/domain/repositories/client_repository.dart';
import 'package:ignicao/shared/errors/failures.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/clients/client_factory.dart';

class MockClientRepository extends Mock implements ClientRepository {}

void main() {
  late DeleteClientUseCase sut;
  late MockClientRepository mockClientRepository;

  final tClientInput = clientOutputFactory();
  final tDto = DeleteClientDto(id: tClientInput.id);

  final tClientOutput = clientOutputFactory();

  setUp(() {
    mockClientRepository = MockClientRepository();
    sut = DeleteClientUseCase(mockClientRepository);
  });

  setUpAll(() {
    registerFallbackValue(DeleteClientDto(id: tDto.id));
  });

  test('Should get client from the repository', () async {
    // Arrange
    when(() => mockClientRepository.deleteClient(any()))
        .thenAnswer((_) async => Right(tClientOutput));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Right(tClientOutput));
    verify(() => mockClientRepository.deleteClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });

  test('Should return a failure when dont succeed', () async {
    // Arrange
    when(() => mockClientRepository.deleteClient(any()))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => mockClientRepository.deleteClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });
}
