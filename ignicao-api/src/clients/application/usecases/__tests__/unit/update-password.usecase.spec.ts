import { faker } from '@faker-js/faker';
import { ClientInput } from 'src/clients/application/dto/client-input.dto';
import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ClientInMemoryRepository } from 'src/clients/infra/database/in-memory/repositories/client-in-memory.repository';
import { BcryptjsHashProvider } from 'src/clients/infra/providers/hash-provider/bcryptjs.provider';
import { InvalidPasswordError } from 'src/shared/application/errors/invalid-password-error';
import { HashProvider } from 'src/shared/application/providers/hash-provider';
import { NotFoundError } from 'src/shared/domain/errors/not-found-error';
import { UpdatePasswordUsecase } from '../../update-password.usecase';

describe('UpdatePasswordUsecase unit tests', () => {
  let sut: UpdatePasswordUsecase;
  let repository: ClientInMemoryRepository;
  let hashProvider: HashProvider;
  let props: ClientInput;

  beforeEach(() => {
    props = {
      name: faker.person.firstName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
    };
    repository = new ClientInMemoryRepository();
    hashProvider = new BcryptjsHashProvider();
    sut = new UpdatePasswordUsecase(repository, hashProvider);
  });

  it('should throws error when entity not found', async () => {
    await expect(
      sut.execute({ id: 'invalid_id', password: 'new', oldPassword: 'old' }),
    ).rejects.toThrow(new NotFoundError('Entity not found'));
  });

  it('should throws error when old password is empty', async () => {
    const entity = new ClientInputEntity(props);
    repository.items = [entity];

    await expect(
      sut.execute({ id: entity.id, password: 'new', oldPassword: '' }),
    ).rejects.toThrow(
      new InvalidPasswordError('Old and new password are required'),
    );
  });

  it('should throws error when password doesnt match old', async () => {
    const hash = await hashProvider.generateHash(props.password);
    const entity = new ClientInputEntity({ ...props, password: hash });
    repository.items = [entity];

    await expect(
      sut.execute({ id: entity.id, password: 'new', oldPassword: 'old' }),
    ).rejects.toThrow(new InvalidPasswordError('Password does not match'));
  });

  it('should return an updated user', async () => {
    const spyUpdate = jest.spyOn(repository, 'update');
    const hash = await hashProvider.generateHash(props.password);
    const items = [new ClientInputEntity({ ...props, password: hash })];
    repository.items = items;

    const result = await sut.execute({
      id: items[0].id,
      password: 'new password',
      oldPassword: props.password,
    });

    expect(spyUpdate).toHaveBeenCalledTimes(1);
    expect(result).toBeDefined();
    expect(result).toMatchObject(items[0].toJson());
  });
});
