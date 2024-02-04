import { faker } from '@faker-js/faker';
import { ClientOutputEntity } from 'src/clients/application/dto/client-output.dto';
import { ClientsController } from '../../clients.controller';
import { SigninDto } from '../../dto/signin.dto';
import { SignupDto } from '../../dto/signup.dto';
import { UpdatePasswordDto } from '../../dto/update-password.dto';
import { ClientPresenter } from '../../presenters/client.presenter';

describe('ClientsController', () => {
  let sut: ClientsController;
  let id: string;
  let props: ClientOutputEntity;

  beforeEach(async () => {
    sut = new ClientsController();
    id = faker.string.uuid();
    props = {
      id,
      name: faker.person.firstName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
      createdAt: new Date(),
    };
  });

  it('should be defined', () => {
    expect(sut).toBeDefined();
  });

  it('should create an user', async () => {
    const output: ClientOutputEntity = props;
    const input: SignupDto = {
      name: props.name,
      email: props.email,
      password: props.password,
    };
    const mockSignupUsecase = {
      execute: jest.fn().mockResolvedValue(Promise.resolve(output)),
    };
    sut['signupUsecase'] = mockSignupUsecase as any;

    const presenter = await sut.signup(input);

    expect(presenter).toBeDefined();
    expect(presenter).toStrictEqual(new ClientPresenter(output));
    expect(mockSignupUsecase.execute).toHaveBeenCalledWith(input);
  });

  it('should authenticate an user', async () => {
    const output = 'fake_token';
    const mockAuthService = {
      generateToken: jest.fn().mockResolvedValue(Promise.resolve(output)),
    };

    sut['authService'] = mockAuthService as any;

    const input: SigninDto = {
      email: props.email,
      password: props.password,
    };

    const mockSigninUsecase = {
      execute: jest.fn().mockResolvedValue(Promise.resolve(output)),
    };
    sut['signinUsecase'] = mockSigninUsecase as any;

    const result = await sut.login(input);

    expect(result).toBeDefined();
    expect(result).toEqual(output);
    expect(mockSigninUsecase.execute).toHaveBeenCalledWith(input);
  });

  it('should update an user', async () => {
    const output: ClientOutputEntity = props;
    const input = {
      id,
      name: faker.person.firstName(),
      email: faker.internet.email(),
    };
    const mockUpdateClientUsecase = {
      execute: jest.fn().mockResolvedValue(Promise.resolve(output)),
    };
    sut['updateClientUsecase'] = mockUpdateClientUsecase as any;

    const presenter = await sut.updateClient(id, input);

    expect(presenter).toBeDefined();
    expect(presenter).toStrictEqual(new ClientPresenter(output));
    expect(mockUpdateClientUsecase.execute).toHaveBeenCalledWith({
      id,
      ...input,
    });
  });

  it('should update an user password', async () => {
    const output: ClientOutputEntity = props;
    const input: UpdatePasswordDto = {
      oldPassword: props.password,
      password: faker.internet.password(),
    };
    const mockUpdatePasswordUsecase = {
      execute: jest.fn().mockResolvedValue(Promise.resolve(output)),
    };
    sut['updatePasswordUsecase'] = mockUpdatePasswordUsecase as any;

    const presenter = await sut.updatePassword(id, input);

    expect(presenter).toBeDefined();
    expect(presenter).toStrictEqual(new ClientPresenter(output));
    expect(mockUpdatePasswordUsecase.execute).toHaveBeenCalledWith({
      id,
      ...input,
    });
  });

  it('should return an user', async () => {
    const output: ClientOutputEntity = props;
    const mockGetClientUsecase = {
      execute: jest.fn().mockResolvedValue(Promise.resolve(output)),
    };
    sut['getClientUsecase'] = mockGetClientUsecase as any;

    const presenter = await sut.findById(id);

    expect(presenter).toBeDefined();
    expect(presenter).toStrictEqual(new ClientPresenter(output));
    expect(mockGetClientUsecase.execute).toHaveBeenCalledWith({ id });
  });

  it('should return all users', async () => {
    const output: ClientOutputEntity[] = [props];
    const mockListClientsUsecase = {
      execute: jest.fn().mockResolvedValue(Promise.resolve(output)),
    };
    sut['listClientsUsecase'] = mockListClientsUsecase as any;

    const presenter = await sut.findAll();

    expect(presenter).toBeDefined();
    expect(presenter).toStrictEqual(
      output.map((client) => new ClientPresenter(client)),
    );
    expect(mockListClientsUsecase.execute).toHaveBeenCalledWith();
  });

  it('should delete an user', async () => {
    const output = undefined;
    const mockDeleteClientUsecase = {
      execute: jest.fn().mockResolvedValue(Promise.resolve(output)),
    };
    sut['deleteClientUsecase'] = mockDeleteClientUsecase as any;

    const result = await sut.delete(id);

    expect(result).toStrictEqual(output);
    expect(mockDeleteClientUsecase.execute).toHaveBeenCalledWith({ id });
  });
});
