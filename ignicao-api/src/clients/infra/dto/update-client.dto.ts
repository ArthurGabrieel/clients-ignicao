import { UpdateClientInput } from 'src/clients/application/usecases/update-client.usecase';

export class UpdateClientDto implements Omit<UpdateClientInput, 'id'> {
  name: string;
  email: string;
}
