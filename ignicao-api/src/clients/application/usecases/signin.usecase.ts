import { ClientRepository } from 'src/clients/domain/repositories/client.repository';
import { InvalidCredentialError } from 'src/shared/application/errors/bad-request-error';
import { BadRequestError } from 'src/shared/application/errors/invalid-credential-error';
import { HashProvider } from 'src/shared/application/providers/hash-provider';
import { UseCase } from 'src/shared/application/usecases/usecase';
import { ClientOutputEntity } from '../dto/client-output.dto';

export type SiginInput = {
  email: string;
  password: string;
};

export class SigninUsecase implements UseCase<SiginInput, ClientOutputEntity> {
  constructor(
    private readonly clientRepository: ClientRepository,
    private readonly hashProvider: HashProvider,
  ) {}

  async execute(input: SiginInput): Promise<ClientOutputEntity> {
    const { email, password } = input;
    if (!email || !password) {
      throw new BadRequestError('Invalid input data');
    }
    const entity = await this.clientRepository.findByEmail(email);
    const passwordMatch = await this.hashProvider.compare(
      password,
      entity.password,
    );

    if (!passwordMatch) {
      throw new InvalidCredentialError('Password missmatch');
    }

    return entity.toJson();
  }
}
