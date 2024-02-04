import { faker } from '@faker-js/faker';
import { ClientInMemoryRepository } from 'src/clients/infra/database/in-memory/repositories/client-in-memory.repository';
import { BcryptjsHashProvider } from 'src/clients/infra/providers/hash-provider/bcryptjs.provider';
import { BadRequestError } from 'src/shared/application/errors/invalid-credential-error';
import { HashProvider } from 'src/shared/application/providers/hash-provider';
import { ConflictError } from 'src/shared/domain/errors/conflict-error';
import { SignupInput, SignupUsecase } from '../../signup.usecase';

describe('SignupUsecase unit tests', () => {
  let sut: SignupUsecase;
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
    sut = new SignupUsecase(repository, hashProvider);
  });

  it('should create an user', async () => {
    const spyCreate = jest.spyOn(repository, 'create');
    const result = await sut.execute(props);

    expect(spyCreate).toHaveBeenCalledTimes(1);
    expect(result).toBeDefined();
    expect(result.id).toBeDefined();
    expect(result.name).toBe(props.name);
    expect(result.email).toBe(props.email);
    expect(result.createdAt).toBeInstanceOf(Date);
  });

  it('should not be able to register with same email', async () => {
    await sut.execute(props);

    expect(() => sut.execute(props)).rejects.toBeInstanceOf(ConflictError);
  });

  it('should not be able to register with invalid name', async () => {
    props = Object.assign(props, { name: null });

    expect(() => sut.execute(props)).rejects.toBeInstanceOf(BadRequestError);
  });

  it('should not be able to register with invalid email', async () => {
    props = Object.assign(props, { email: null });

    expect(() => sut.execute(props)).rejects.toBeInstanceOf(BadRequestError);
  });

  it('should not be able to register with invalid password', async () => {
    props = Object.assign(props, { password: null });

    expect(() => sut.execute(props)).rejects.toBeInstanceOf(BadRequestError);
  });
});
