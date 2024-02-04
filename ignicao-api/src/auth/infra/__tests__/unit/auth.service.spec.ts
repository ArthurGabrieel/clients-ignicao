import { JwtModule, JwtService } from '@nestjs/jwt';
import { Test, TestingModule } from '@nestjs/testing';
import { AuthService } from '../../auth.service';

describe('AuthService unit tests', () => {
  let sut: AuthService;
  let module: TestingModule;
  let jwtService: JwtService;

  beforeAll(async () => {
    module = await Test.createTestingModule({
      imports: [JwtModule],
      providers: [AuthService],
    }).compile();
  });

  beforeEach(async () => {
    jwtService = new JwtService({
      global: true,
      secret: 'ignicao_secret',
      signOptions: { expiresIn: '1d', subject: 'id' },
    });

    sut = new AuthService(jwtService);
  });

  it('should be defined', () => {
    expect(sut).toBeDefined();
  });

  it('should return a jwt', async () => {
    const result = await sut.generateToken('id');

    expect(Object.keys(result)).toEqual(['accessToken']);
    expect(typeof result.accessToken).toEqual('string');
  });

  it('should verify a jwt', async () => {
    const result = await sut.generateToken('id');
    const validToken = await sut.verifyToken(result.accessToken);

    expect(validToken).not.toBeNull();
    await expect(sut.verifyToken('invalid_token')).rejects.toThrow();
    await expect(
      sut.verifyToken(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
      ),
    ).rejects.toThrow();
  });
});
