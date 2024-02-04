import { ClientRepository } from 'src/clients/domain/repositories/client.repository';
import { BadRequestError } from 'src/shared/application/errors/invalid-credential-error';
import { UseCase } from 'src/shared/application/usecases/usecase';
import { ClientOutputEntity } from '../dto/client-output.dto';

export type UpdateClientInput = {
  id: string;
  name: string;
  email: string;
};

export class UpdateClientUsecase
  implements UseCase<UpdateClientInput, ClientOutputEntity>
{
  constructor(private readonly clientRepository: ClientRepository) {}

  async execute(input: UpdateClientInput): Promise<ClientOutputEntity> {
    if (!input.id || !input.name || !input.email) {
      throw new BadRequestError('Invalid input data');
    }
    const entity = await this.clientRepository.findById(input.id);
    entity.update(input);

    await this.clientRepository.update(entity);
    return entity.toJson();
  }
}
