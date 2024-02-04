import { faker } from '@faker-js/faker';
import { BcryptjsHashProvider } from '../../bcryptjs.provider';

describe('BcryptjsProvider unit tests', () => {
  let sut: BcryptjsHashProvider;
  let password: string;

  beforeEach(() => {
    sut = new BcryptjsHashProvider();
    password = faker.internet.password();
  });

  it('should return an encrypted password', () => {
    const encryptedPassword = sut.generateHash(password);

    expect(sut).toBeDefined();
    expect(encryptedPassword).toBeDefined();
  });

  it('should return false on invalid password', async () => {
    const encryptedPassword = await sut.generateHash(password);
    const result = await sut.compare('invalid_password', encryptedPassword);
    expect(result).toBeFalsy();
  });

  it('should return true on valid password', async () => {
    const encryptedPassword = await sut.generateHash(password);
    const result = await sut.compare(password, encryptedPassword);
    expect(result).toBeTruthy();
  });
});
