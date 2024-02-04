import { ClientRepository } from 'src/clients/domain/repositories/client.repository';
import { UseCase } from 'src/shared/application/usecases/usecase';
import { ClientOutputEntity } from '../dto/client-output.dto';

export type Input = {
  id: string;
};

export class GetClientUsecase implements UseCase<Input, ClientOutputEntity> {
  constructor(private readonly clientRepository: ClientRepository) {}

  async execute(input: Input): Promise<ClientOutputEntity> {
    const entity = await this.clientRepository.findById(input.id);
    return entity.toJson();
  }
}
