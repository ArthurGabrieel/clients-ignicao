import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ignicao/features/clients/data/usecases/update_password_usecase.dart';
import 'package:ignicao/features/clients/domain/dto/update_password_dto.dart';
import 'package:ignicao/features/clients/domain/repositories/client_repository.dart';
import 'package:ignicao/shared/errors/failures.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/clients/client_factory.dart';

class MockClientRepository extends Mock implements ClientRepository {}

void main() {
  late UpdatePasswordUseCase sut;
  late MockClientRepository mockClientRepository;

  final tClientInput = clientInputFactory();
  final tDto = UpdatePasswordDto(
    id: tClientInput.id,
    password: 'new',
    oldPassword: tClientInput.password,
  );

  final tClientOutput = clientOutputFactory();

  setUp(() {
    mockClientRepository = MockClientRepository();
    sut = UpdatePasswordUseCase(mockClientRepository);
  });

  setUpAll(() {
    registerFallbackValue(UpdatePasswordDto(
      id: tDto.id,
      password: tDto.password,
      oldPassword: tDto.oldPassword,
    ));
  });

  test('Should get client from the repository', () async {
    // Arrange
    when(() => mockClientRepository.updatePassword(any()))
        .thenAnswer((_) async => Right(tClientOutput));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Right(tClientOutput));
    verify(() => mockClientRepository.updatePassword(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });

  test('Should return a failure when dont succeed', () async {
    // Arrange
    when(() => mockClientRepository.updatePassword(any()))
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => mockClientRepository.updatePassword(tDto));
    verifyNoMoreInteractions(mockClientRepository);
  });
}
