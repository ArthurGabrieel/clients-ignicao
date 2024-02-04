import { faker } from '@faker-js/faker';
import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ClientInMemoryRepository } from 'src/clients/infra/database/in-memory/repositories/client-in-memory.repository';
import { ListClientsUsecase } from '../../list-clients.usecase';

describe('ListClientsUsecase unit tests', () => {
  let sut: ListClientsUsecase;
  let repository: ClientInMemoryRepository;

  beforeEach(() => {
    repository = new ClientInMemoryRepository();
    sut = new ListClientsUsecase(repository);
  });

  it('should return an empty array when no clients are found', async () => {
    const result = await sut.execute();

    expect(result).toEqual([]);
  });

  it('should return an array of ClientOutputEntity when clients are found', async () => {
    const clients = [
      new ClientInputEntity({
        name: faker.person.firstName(),
        email: faker.internet.email(),
        password: faker.internet.password(),
      }),
      new ClientInputEntity({
        name: faker.person.firstName(),
        email: faker.internet.email(),
        password: faker.internet.password(),
      }),
    ];

    repository.items = clients;

    const result = await sut.execute();

    expect(result).toHaveLength(clients.length);
    expect(result).toEqual(clients.map((client) => client.toJson()));
  });
});
