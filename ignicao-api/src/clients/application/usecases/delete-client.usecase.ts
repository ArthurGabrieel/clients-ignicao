import { ClientRepository } from 'src/clients/domain/repositories/client.repository';
import { UseCase } from 'src/shared/application/usecases/usecase';

export type DeleteInput = {
  id: string;
};

export class DeleteClientUsecase implements UseCase<DeleteInput, void> {
  constructor(private readonly clientRepository: ClientRepository) {}

  async execute(deleteInput: DeleteInput): Promise<void> {
    await this.clientRepository.delete(deleteInput.id);
  }
}
