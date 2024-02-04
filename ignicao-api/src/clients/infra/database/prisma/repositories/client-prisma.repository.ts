import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ClientRepository } from 'src/clients/domain/repositories/client.repository';
import { ConflictError } from 'src/shared/domain/errors/conflict-error';
import { NotFoundError } from 'src/shared/domain/errors/not-found-error';
import { PrismaService } from 'src/shared/infra/database/prisma/prisma.service';
import { ClientInputModelMapper } from '../models/client-model.mapper';

export class ClientPrismaRepository implements ClientRepository {
  constructor(private readonly prismaService: PrismaService) {}

  async findByEmail(email: string): Promise<ClientInputEntity> {
    try {
      const client = await this.prismaService.client.findFirst({
        where: { email },
      });

      return ClientInputModelMapper.toEntity(client);
    } catch (_) {
      throw new NotFoundError(`User not found using email ${email}`);
    }
  }
  async emailExists(email: string): Promise<void> {
    const client = await this.prismaService.client.findFirst({
      where: { email },
    });

    if (client) {
      throw new ConflictError(`Email ${email} already exists`);
    }
  }
  async create(entity: ClientInputEntity): Promise<void> {
    await this.prismaService.client.create({
      data: entity.toJson(),
    });
  }
  async update(entity: ClientInputEntity): Promise<void> {
    await this._get(entity.id);
    await this.prismaService.client.update({
      where: { id: entity.id },
      data: entity.toJson(),
    });
  }
  async delete(id: string): Promise<void> {
    await this._get(id);
    await this.prismaService.client.delete({
      where: { id },
    });
  }
  async findById(id: string): Promise<ClientInputEntity> {
    return this._get(id);
  }
  async findAll(): Promise<ClientInputEntity[]> {
    const clients = await this.prismaService.client.findMany();
    return clients.map((client) => ClientInputModelMapper.toEntity(client));
  }

  private async _get(id: string): Promise<ClientInputEntity> {
    try {
      const client = await this.prismaService.client.findUnique({
        where: { id },
      });

      return ClientInputModelMapper.toEntity(client);
    } catch (_) {
      throw new NotFoundError(`User not found using id ${id}`);
    }
  }
}
