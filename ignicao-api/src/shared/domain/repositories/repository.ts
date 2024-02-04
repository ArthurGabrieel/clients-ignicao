import { Entity } from '../entities/entity';

export interface Repository<E extends Entity> {
  create(entity: E): Promise<void>;
  update(entity: E): Promise<void>;
  delete(id: string): Promise<void>;
  findById(id: string): Promise<E | null>;
  findAll(): Promise<E[]>;
}
