import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ignicao/features/auth/data/dto/login_dto.dart';
import 'package:ignicao/features/auth/data/usecases/login_usecase.dart';
import 'package:ignicao/features/clients/domain/repositories/client_repository.dart';
import 'package:ignicao/shared/errors/failures.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/clients/client_factory.dart';

class MockClientRepository extends Mock implements ClientRepository {}

void main() {
  late LoginUseCase sut;
  late MockClientRepository mockClientRepository;

  final tClientInput = clientInputFactory();
  final tDto =
      LoginDto(email: tClientInput.email, password: tClientInput.password);
  const output = 'token_jwt';

  setUp(() {
    mockClientRepository = MockClientRepository();
    sut = LoginUseCase(mockClientRepository);
  });

  setUpAll(() {
    registerFallbackValue(LoginDto(
      email: tDto.email,
      password: tDto.password,
    ));
  });

  test('Should get client from the repository', () async {
    // Arrange
    when(() => mockClientRepository.loginClient(any()))
        .thenAnswer((_) async => const Right(output));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, const Right(output));
    verify(() => mockClientRepository.loginClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });

  test('Should return a failure when dont succeed', () async {
    // Arrange
    when(() => mockClientRepository.loginClient(any()))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => mockClientRepository.loginClient(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });
}
