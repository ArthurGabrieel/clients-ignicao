import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/infra/auth.module';
import { ClientsModule } from './clients/infra/clients.module';
import { DatabaseModule } from './shared/infra/database/database.module';

@Module({
  imports: [ClientsModule, DatabaseModule, AuthModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
