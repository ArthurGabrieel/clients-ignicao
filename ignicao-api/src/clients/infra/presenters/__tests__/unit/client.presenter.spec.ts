import { faker } from '@faker-js/faker';
import { instanceToPlain } from 'class-transformer';
import { ClientPresenter } from '../../client.presenter';

describe('ClientPresenter', () => {
  const props = {
    id: faker.string.uuid(),
    name: faker.person.firstName(),
    email: faker.internet.email(),
    password: faker.internet.password(),
    createdAt: new Date(),
  };

  let sut: ClientPresenter;

  beforeEach(() => {
    sut = new ClientPresenter(props);
  });

  it('should create a new client presenter', () => {
    expect(sut).toBeInstanceOf(ClientPresenter);
    expect(sut.id).toEqual(props.id);
    expect(sut.name).toEqual(props.name);
    expect(sut.email).toEqual(props.email);
    expect(sut.createdAt).toEqual(props.createdAt);
  });

  it('should presenter data', () => {
    const output = instanceToPlain(sut);

    expect(output).toStrictEqual({
      id: props.id,
      name: props.name,
      email: props.email,
      createdAt: props.createdAt.toISOString(),
    });
  });
});
