import { ClientRepository } from 'src/clients/domain/repositories/client.repository';
import { InvalidPasswordError } from 'src/shared/application/errors/invalid-password-error';
import { HashProvider } from 'src/shared/application/providers/hash-provider';
import { UseCase } from 'src/shared/application/usecases/usecase';
import { ClientOutputEntity } from '../dto/client-output.dto';

export type UpdatePasswordInput = {
  id: string;
  password: string;
  oldPassword: string;
};

export class UpdatePasswordUsecase
  implements UseCase<UpdatePasswordInput, ClientOutputEntity>
{
  constructor(
    private readonly clientRepository: ClientRepository,
    private readonly hashProvider: HashProvider,
  ) {}

  async execute(input: UpdatePasswordInput): Promise<ClientOutputEntity> {
    const entity = await this.clientRepository.findById(input.id);
    if (!input.oldPassword || !input.password) {
      throw new InvalidPasswordError('Old and new password are required');
    }

    const checkOldPassword = await this.hashProvider.compare(
      input.oldPassword,
      entity.password,
    );

    if (!checkOldPassword) {
      throw new InvalidPasswordError('Password does not match');
    }

    const hashPassword = await this.hashProvider.generateHash(input.password);
    entity.changePassword(hashPassword);

    await this.clientRepository.update(entity);
    return entity.toJson();
  }
}
