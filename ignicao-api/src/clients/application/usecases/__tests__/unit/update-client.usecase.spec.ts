import { faker } from '@faker-js/faker';
import { ClientInput } from 'src/clients/application/dto/client-input.dto';
import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ClientInMemoryRepository } from 'src/clients/infra/database/in-memory/repositories/client-in-memory.repository';
import { BadRequestError } from 'src/shared/application/errors/invalid-credential-error';
import { NotFoundError } from 'src/shared/domain/errors/not-found-error';
import { UpdateClientUsecase } from '../../update-client.usecase';

describe('UpdateClientUsecase unit tests', () => {
  let sut: UpdateClientUsecase;
  let repository: ClientInMemoryRepository;
  let props: ClientInput;

  beforeEach(() => {
    props = {
      name: faker.person.firstName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
    };
    repository = new ClientInMemoryRepository();
    sut = new UpdateClientUsecase(repository);
  });

  it('should throws error when entity not found', async () => {
    await expect(
      sut.execute({ id: 'invalid_id', name: 'test', email: 'test' }),
    ).rejects.toThrow(new NotFoundError('Entity not found'));
  });

  it('should throws error when name and email empty', async () => {
    await expect(
      sut.execute({ id: 'invalid_id', name: '', email: '' }),
    ).rejects.toThrow(new BadRequestError('Invalid input data'));
  });

  it('should return an updated user', async () => {
    const spyUpdate = jest.spyOn(repository, 'update');
    const items = [new ClientInputEntity(props)];
    repository.items = items;

    const result = await sut.execute({
      id: items[0].id,
      name: 'new name',
      email: 'new email',
    });

    expect(spyUpdate).toHaveBeenCalledTimes(1);
    expect(result).toBeDefined();
    expect(result).toMatchObject(items[0].toJson());
  });
});
