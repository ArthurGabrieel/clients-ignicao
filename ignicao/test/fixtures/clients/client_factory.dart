import 'package:faker/faker.dart';
import 'package:ignicao/features/clients/domain/entities/client_input.dart';
import 'package:ignicao/features/clients/domain/entities/client_output.dart';
import 'package:uuid/uuid.dart';

ClientInputEntity clientInputFactory() => ClientInputEntity(
      id: const Uuid().v4(),
      name: faker.person.name(),
      email: faker.internet.email(),
      password: faker.internet.password(),
      createdAt: DateTime.now(),
    );

ClientOutputEntity clientOutputFactory() => ClientOutputEntity(
      id: const Uuid().v4(),
      name: faker.person.name(),
      email: faker.internet.email(),
      createdAt: DateTime.now(),
    );
