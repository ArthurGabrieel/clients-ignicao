import { Entity } from '../entities/entity';
import { NotFoundError } from '../errors/not-found-error';
import { Repository } from './repository';

export abstract class InMemoryRepository<E extends Entity>
  implements Repository<E>
{
  items: E[] = [];

  async create(entity: E): Promise<void> {
    this.items.push(entity);
  }

  async update(entity: E): Promise<void> {
    await this._get(entity.id);
    const index = this.items.findIndex((item) => item.id === entity.id);
    this.items[index] = entity;
  }

  async delete(id: string): Promise<void> {
    await this._get(id);
    const index = this.items.findIndex((item) => item.id === id);
    this.items.splice(index, 1);
  }

  async findById(id: string): Promise<E> {
    return this._get(id);
  }

  async findAll(): Promise<E[]> {
    return this.items;
  }

  protected async _get(id: string): Promise<E> {
    const _id = `${id}`;
    const entity = this.items.find((item) => item.id === _id);
    if (!entity) {
      throw new NotFoundError(`Entity not found`);
    }
    return entity;
  }
}