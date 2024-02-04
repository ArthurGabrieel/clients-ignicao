import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ClientRepository } from 'src/clients/domain/repositories/client.repository';
import { BadRequestError } from 'src/shared/application/errors/invalid-credential-error';
import { HashProvider } from 'src/shared/application/providers/hash-provider';
import { UseCase } from 'src/shared/application/usecases/usecase';
import { ClientOutputEntity } from '../dto/client-output.dto';

export type SignupInput = {
  name: string;
  email: string;
  password: string;
};

export class SignupUsecase implements UseCase<SignupInput, ClientOutputEntity> {
  constructor(
    private readonly clientRepository: ClientRepository,
    private readonly hashProvider: HashProvider,
  ) {}

  async execute(input: SignupInput): Promise<ClientOutputEntity> {
    const { name, email, password } = input;
    if (!name || !email || !password) {
      throw new BadRequestError('Invalid input data');
    }
    await this.clientRepository.emailExists(email);

    const hashedPassword = await this.hashProvider.generateHash(password);
    const entity = new ClientInputEntity(
      Object.assign(input, { password: hashedPassword }),
    );

    await this.clientRepository.create(entity);
    return entity.toJson();
  }
}
