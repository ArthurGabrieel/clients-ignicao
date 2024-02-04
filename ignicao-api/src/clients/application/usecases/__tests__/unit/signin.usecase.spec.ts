import { faker } from '@faker-js/faker';
import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ClientInMemoryRepository } from 'src/clients/infra/database/in-memory/repositories/client-in-memory.repository';
import { BcryptjsHashProvider } from 'src/clients/infra/providers/hash-provider/bcryptjs.provider';
import { InvalidCredentialError } from 'src/shared/application/errors/bad-request-error';
import { BadRequestError } from 'src/shared/application/errors/invalid-credential-error';
import { HashProvider } from 'src/shared/application/providers/hash-provider';
import { SigninUsecase } from '../../signin.usecase';
import { SignupInput } from '../../signup.usecase';

describe('SigninUsecase unit tests', () => {
  let sut: SigninUsecase;
  let repository: ClientInMemoryRepository;
  let hashProvider: HashProvider;
  let props: SignupInput;

  beforeEach(() => {
    props = {
      name: faker.person.firstName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
    };
    repository = new ClientInMemoryRepository();
    hashProvider = new BcryptjsHashProvider();
    sut = new SigninUsecase(repository, hashProvider);
  });

  it('should authenticate an user', async () => {
    const spyFindByEmail = jest.spyOn(repository, 'findByEmail');
    const hashPassword = await hashProvider.generateHash(props.password);
    const entity = new ClientInputEntity({ ...props, password: hashPassword });
    repository.items = [entity];

    const result = await sut.execute({
      email: entity.email,
      password: props.password,
    });

    expect(spyFindByEmail).toHaveBeenCalledTimes(1);
    expect(result).toStrictEqual(entity.toJson());
  });

  it('should throw BadRequestError for missing email', async () => {
    props = { ...props, email: '' };

    await expect(sut.execute(props)).rejects.toThrow(BadRequestError);
  });

  it('should throw BadRequestError for missing password', async () => {
    props = { ...props, password: '' };

    await expect(sut.execute(props)).rejects.toThrow(BadRequestError);
  });

  it('should throw InvalidCredentialError for incorrect password', async () => {
    const spyFindByEmail = jest.spyOn(repository, 'findByEmail');
    const entity = new ClientInputEntity({
      ...props,
      password: await hashProvider.generateHash('correct_password'),
    });
    repository.items = [entity];

    await expect(
      sut.execute({
        email: entity.email,
        password: 'incorrect_password',
      }),
    ).rejects.toThrow(InvalidCredentialError);

    expect(spyFindByEmail).toHaveBeenCalledTimes(1);
  });
});
