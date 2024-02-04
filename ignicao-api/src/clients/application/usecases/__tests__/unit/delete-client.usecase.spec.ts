import { faker } from '@faker-js/faker';
import { ClientInput } from 'src/clients/application/dto/client-input.dto';
import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ClientInMemoryRepository } from 'src/clients/infra/database/in-memory/repositories/client-in-memory.repository';
import { NotFoundError } from 'src/shared/domain/errors/not-found-error';
import { DeleteClientUsecase } from '../../delete-client.usecase';

describe('DeleteClientUsecase unit tests', () => {
  let sut: DeleteClientUsecase;
  let repository: ClientInMemoryRepository;
  let props: ClientInput;

  beforeEach(() => {
    props = {
      name: faker.person.firstName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
    };
    repository = new ClientInMemoryRepository();
    sut = new DeleteClientUsecase(repository);
  });

  it('should throws error when entity not found', async () => {
    await expect(sut.execute({ id: 'invalid_id' })).rejects.toThrow(
      new NotFoundError('Entity not found'),
    );
  });

  it('should delete an user', async () => {
    const spyDelete = jest.spyOn(repository, 'delete');
    const items = [new ClientInputEntity(props)];
    repository.items = items;

    expect(repository.items).toHaveLength(1);

    await sut.execute({ id: items[0].id });

    expect(spyDelete).toHaveBeenCalledTimes(1);
    expect(repository.items).toHaveLength(0);
  });
});
