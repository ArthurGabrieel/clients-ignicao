import { Client } from '@prisma/client';
import { ClientInputEntity } from 'src/clients/domain/entities/client.entity';
import { ValidationError } from 'src/shared/domain/errors/validation-error';

export class ClientInputModelMapper {
  static toEntity(model: Client) {
    const data = {
      name: model.name,
      email: model.email,
      password: model.password,
      createdAt: model.createdAt,
    };

    try {
      return new ClientInputEntity(data, model.id);
    } catch (error) {
      throw new ValidationError('Error parsing client model to entity');
    }
  }
}
