import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ignicao/features/clients/data/usecases/get_all_clients_usecase.dart';
import 'package:ignicao/features/clients/domain/repositories/client_repository.dart';
import 'package:ignicao/shared/data/usecases/usecase.dart';
import 'package:ignicao/shared/errors/failures.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/clients/client_factory.dart';

class MockClientRepository extends Mock implements ClientRepository {}

void main() {
  late GetAllClientUseCase sut;
  late MockClientRepository mockClientRepository;

  final tClientsOutputList = [clientOutputFactory(), clientOutputFactory()];
  final tDto = NoParams();

  setUp(() {
    mockClientRepository = MockClientRepository();
    sut = GetAllClientUseCase(mockClientRepository);
  });

  test('Should get client from the repository', () async {
    // Arrange
    when(() => mockClientRepository.getClients())
        .thenAnswer((_) async => Right(tClientsOutputList));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Right(tClientsOutputList));
    verify(() => mockClientRepository.getClients());
    verifyNoMoreInteractions(mockClientRepository);
  });

  test('Should return a failure when dont succeed', () async {
    // Arrange
    when(() => mockClientRepository.getClients())
        .thenAnswer((_) async => Left(ServerFailure()));

    // Act
    final result = await sut(tDto);

    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => mockClientRepository.getClients());
    verifyNoMoreInteractions(mockClientRepository);
  });
}
