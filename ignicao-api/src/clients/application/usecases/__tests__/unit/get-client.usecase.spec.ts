import { faker } from '@faker-js/faker';
import { ClientInput } from 'src/clients/application/dto/client-input.dto';
import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ClientInMemoryRepository } from 'src/clients/infra/database/in-memory/repositories/client-in-memory.repository';
import { NotFoundError } from 'src/shared/domain/errors/not-found-error';
import { GetClientUsecase } from '../../get-client.usecase';

describe('GetClientUsecase unit tests', () => {
  let sut: GetClientUsecase;
  let repository: ClientInMemoryRepository;
  let props: ClientInput;

  beforeEach(() => {
    props = {
      name: faker.person.firstName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
    };
    repository = new ClientInMemoryRepository();
    sut = new GetClientUsecase(repository);
  });

  it('should throws error when entity not found', async () => {
    await expect(sut.execute({ id: 'invalid_id' })).rejects.toThrow(
      new NotFoundError('Entity not found'),
    );
  });

  it('should return an user', async () => {
    const spyFindById = jest.spyOn(repository, 'findById');
    const items = [new ClientInputEntity(props)];
    repository.items = items;

    const result = await sut.execute({ id: items[0].id });

    expect(spyFindById).toHaveBeenCalledTimes(1);
    expect(result).toBeDefined();
    expect(result).toMatchObject(items[0].toJson());
  });
});
