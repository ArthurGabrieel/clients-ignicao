import { faker } from '@faker-js/faker';
import { ClientInputEntity, ClientProps } from '../../client.entity';

describe('ClientInputEntity unit tests', () => {
  let props: ClientProps;
  let sut: ClientInputEntity;

  beforeEach(() => {
    props = {
      name: faker.person.fullName(),
      email: faker.internet.email(),
      password: faker.internet.password(),
    };

    sut = new ClientInputEntity(props);
  });

  it('should create a new client entity', () => {
    expect(sut).toBeInstanceOf(ClientInputEntity);
    expect(sut.name).toEqual(props.name);
    expect(sut.email).toEqual(props.email);
    expect(sut.password).toEqual(props.password);
    expect(sut.createdAt).toBeInstanceOf(Date);
  });

  it('should return the name', () => {
    expect(sut.name).toBeDefined();
    expect(sut.name).toEqual(props.name);
    expect(typeof sut.name).toEqual('string');
  });

  it('should return the email', () => {
    expect(sut.email).toBeDefined();
    expect(sut.email).toEqual(props.email);
    expect(typeof sut.email).toEqual('string');
  });

  it('should return the password', () => {
    expect(sut.password).toBeDefined();
    expect(sut.password).toEqual(props.password);
    expect(typeof sut.password).toBe('string');
  });

  it('should return the createdAt', () => {
    expect(sut.createdAt).toBeDefined();
    expect(sut.createdAt).toBeInstanceOf(Date);
  });

  it('should update the client entity', () => {
    const newProps = {
      name: faker.person.fullName(),
      email: faker.internet.email(),
    };

    sut.update(newProps);

    expect(sut.name).toEqual(newProps.name);
    expect(sut.email).toEqual(newProps.email);
  });

  it('should update the client password', () => {
    const password = 'new_password';

    sut.changePassword(password);

    expect(sut.password).toEqual(password);
  });
});
