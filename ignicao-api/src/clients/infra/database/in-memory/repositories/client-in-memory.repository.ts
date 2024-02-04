import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ClientRepository } from 'src/clients/domain/repositories/client.repository';
import { ConflictError } from 'src/shared/domain/errors/conflict-error';
import { NotFoundError } from 'src/shared/domain/errors/not-found-error';
import { InMemoryRepository } from 'src/shared/domain/repositories/in-memory.repository';

export class ClientInMemoryRepository
  extends InMemoryRepository<ClientInputEntity>
  implements ClientRepository
{
  async findByEmail(email: string): Promise<ClientInputEntity> {
    const entity = this.items.find((item) => item.email === email);
    if (!entity) {
      throw new NotFoundError(`Entity not found using email: ${email}`);
    }
    return entity;
  }

  async emailExists(email: string): Promise<void> {
    const entity = this.items.find((item) => item.email === email);
    if (entity) {
      throw new ConflictError(`Email already exists: ${email}`);
    }
  }
}
