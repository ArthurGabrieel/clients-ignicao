import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ignicao/features/clients/data/usecases/register_usecase.dart';
import 'package:ignicao/features/clients/domain/dto/register_dto.dart';
import 'package:ignicao/features/clients/domain/repositories/client_repository.dart';
import 'package:ignicao/shared/errors/failures.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/clients/client_factory.dart';

class MockClientRepository extends Mock implements ClientRepository {}

void main() {
  late RegisterUseCase sut;
  late MockClientRepository mockClientRepository;

  final tClientInput = clientInputFactory();
  final tDto = RegisterDto(
    name: tClientInput.name,
    email: tClientInput.email,
    password: tClientInput.password,
  );

  final tClientOutput = clientOutputFactory();

  setUp(() {
    mockClientRepository = MockClientRepository();
    sut = RegisterUseCase(mockClientRepository);
  });

  setUpAll(() {
    registerFallbackValue(RegisterDto(
      name: tDto.name,
      email: tDto.email,
      password: tDto.password,
    ));
  });

  test('Should get client from the repository', () async {
    // Arrange
    when(() => mockClientRepository.registerClient(any()))
        .thenAnswer((_) async => Right(tClientOutput));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Right(tClientOutput));
    verify(() => mockClientRepository.registerClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });

  test('Should return a failure when dont succeed', () async {
    // Arrange
    when(() => mockClientRepository.registerClient(any()))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => mockClientRepository.registerClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });
}
