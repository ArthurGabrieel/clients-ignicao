import { ClientRepository } from 'src/clients/domain/repositories/client.repository';
import { UseCase } from 'src/shared/application/usecases/usecase';
import { ClientOutputEntity } from '../dto/client-output.dto';

type Input = void;

export class ListClientsUsecase
  implements UseCase<Input, [ClientOutputEntity]>
{
  constructor(private readonly clientRepository: ClientRepository) {}

  async execute(): Promise<[ClientOutputEntity]> {
    const entities = await this.clientRepository.findAll();

    return entities.map((entity) => entity.toJson()) as [ClientOutputEntity];
  }
}
