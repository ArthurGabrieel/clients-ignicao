import { Repository } from 'src/shared/domain/repositories/repository';
import { ClientInputEntity } from '../entities/client.entity';

export interface ClientRepository extends Repository<ClientInputEntity> {
  findByEmail(email: string): Promise<ClientInputEntity>;
  emailExists(email: string): Promise<void>;
}
