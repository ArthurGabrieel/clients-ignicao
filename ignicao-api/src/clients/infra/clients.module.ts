import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth/infra/auth.module';
import { PrismaService } from 'src/shared/infra/database/prisma/prisma.service';
import { DeleteClientUsecase } from '../application/usecases/delete-client.usecase';
import { GetClientByEmailUsecase } from '../application/usecases/get-client-by-email.usecase';
import { GetClientUsecase } from '../application/usecases/get-client.usecase';
import { ListClientsUsecase } from '../application/usecases/list-clients.usecase';
import { SigninUsecase } from '../application/usecases/signin.usecase';
import { SignupUsecase } from '../application/usecases/signup.usecase';
import { UpdateClientUsecase } from '../application/usecases/update-client.usecase';
import { UpdatePasswordUsecase } from '../application/usecases/update-password.usecase';
import { ClientsController } from './clients.controller';
import { ClientPrismaRepository } from './database/prisma/repositories/client-prisma.repository';
import { BcryptjsHashProvider } from './providers/hash-provider/bcryptjs.provider';

@Module({
  imports: [AuthModule],
  controllers: [ClientsController],
  providers: [
    {
      provide: 'PrismaService',
      useClass: PrismaService,
    },
    {
      provide: 'ClientRepository',
      useFactory: (prismaService) => new ClientPrismaRepository(prismaService),
      inject: ['PrismaService'],
    },
    {
      provide: 'HashProvider',
      useClass: BcryptjsHashProvider,
    },
    {
      provide: SignupUsecase,
      useFactory: (clientRepository, hashProvider) =>
        new SignupUsecase(clientRepository, hashProvider),
      inject: ['ClientRepository', 'HashProvider'],
    },
    {
      provide: SigninUsecase,
      useFactory: (clientRepository, hashProvider) =>
        new SigninUsecase(clientRepository, hashProvider),
      inject: ['ClientRepository', 'HashProvider'],
    },
    {
      provide: GetClientUsecase,
      useFactory: (clientRepository) => new GetClientUsecase(clientRepository),
      inject: ['ClientRepository'],
    },
    {
      provide: GetClientByEmailUsecase,
      useFactory: (clientRepository) =>
        new GetClientByEmailUsecase(clientRepository),
      inject: ['ClientRepository'],
    },
    {
      provide: UpdateClientUsecase,
      useFactory: (clientRepository) =>
        new UpdateClientUsecase(clientRepository),
      inject: ['ClientRepository'],
    },
    {
      provide: UpdatePasswordUsecase,
      useFactory: (clientRepository, hashProvider) =>
        new UpdatePasswordUsecase(clientRepository, hashProvider),
      inject: ['ClientRepository', 'HashProvider'],
    },
    {
      provide: ListClientsUsecase,
      useFactory: (clientRepository) =>
        new ListClientsUsecase(clientRepository),
      inject: ['ClientRepository'],
    },
    {
      provide: DeleteClientUsecase,
      useFactory: (clientRepository) =>
        new DeleteClientUsecase(clientRepository),
      inject: ['ClientRepository'],
    },
  ],
})
export class ClientsModule {}
