import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Inject,
  Param,
  Patch,
  Post,
  Put,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from 'src/auth/infra/auth.service';
import { ClientOutputEntity } from '../application/dto/client-output.dto';
import { DeleteClientUsecase } from '../application/usecases/delete-client.usecase';
import { GetClientByEmailUsecase } from '../application/usecases/get-client-by-email.usecase';
import { GetClientUsecase } from '../application/usecases/get-client.usecase';
import { ListClientsUsecase } from '../application/usecases/list-clients.usecase';
import { SigninUsecase } from '../application/usecases/signin.usecase';
import { SignupUsecase } from '../application/usecases/signup.usecase';
import { UpdateClientUsecase } from '../application/usecases/update-client.usecase';
import { UpdatePasswordUsecase } from '../application/usecases/update-password.usecase';
import { AuthGuard } from './auth.guard';
import { SigninDto } from './dto/signin.dto';
import { SignupDto } from './dto/signup.dto';
import { UpdateClientDto } from './dto/update-client.dto';
import { UpdatePasswordDto } from './dto/update-password.dto';
import { ClientPresenter } from './presenters/client.presenter';

@Controller('clients')
export class ClientsController {
  @Inject(SignupUsecase)
  private signupUsecase: SignupUsecase;

  @Inject(SigninUsecase)
  private signinUsecase: SigninUsecase;

  @Inject(UpdateClientUsecase)
  private updateClientUsecase: UpdateClientUsecase;

  @Inject(UpdatePasswordUsecase)
  private updatePasswordUsecase: UpdatePasswordUsecase;

  @Inject(DeleteClientUsecase)
  private deleteClientUsecase: DeleteClientUsecase;

  @Inject(GetClientUsecase)
  private getClientUsecase: GetClientUsecase;

  @Inject(ListClientsUsecase)
  private listClientsUsecase: ListClientsUsecase;

  @Inject(GetClientByEmailUsecase)
  private getClientByEmailUsecase: GetClientByEmailUsecase;

  @Inject(AuthService)
  private authService: AuthService;

  static clientToResponse(output: ClientOutputEntity) {
    return new ClientPresenter(output);
  }

  @Post('register')
  async signup(@Body() signupDto: SignupDto) {
    const output = await this.signupUsecase.execute(signupDto);
    return ClientsController.clientToResponse(output);
  }

  @HttpCode(200)
  @Post('login')
  async login(@Body() signinDto: SigninDto) {
    const output = await this.signinUsecase.execute(signinDto);
    return this.authService.generateToken(output.id);
  }

  @UseGuards(AuthGuard)
  @Get()
  async findAll() {
    const output = await this.listClientsUsecase.execute();
    return output.map(ClientsController.clientToResponse);
  }

  @UseGuards(AuthGuard)
  @Get(':id')
  async findById(@Param('id') id: string) {
    const output = await this.getClientUsecase.execute({ id });
    return ClientsController.clientToResponse(output);
  }

  @UseGuards(AuthGuard)
  @Get('/search/:email')
  async findByEmail(@Param('email') email: string) {
    const output = await this.getClientByEmailUsecase.execute({ email });
    return ClientsController.clientToResponse(output);
  }

  @UseGuards(AuthGuard)
  @Put(':id')
  async updateClient(
    @Param('id') id: string,
    @Body() updateClientDto: UpdateClientDto,
  ) {
    const output = await this.updateClientUsecase.execute({
      id,
      ...updateClientDto,
    });
    return ClientsController.clientToResponse(output);
  }

  @UseGuards(AuthGuard)
  @Patch(':id')
  async updatePassword(
    @Param('id') id: string,
    @Body() updatePasswordDto: UpdatePasswordDto,
  ) {
    const output = await this.updatePasswordUsecase.execute({
      id,
      ...updatePasswordDto,
    });
    return ClientsController.clientToResponse(output);
  }

  @UseGuards(AuthGuard)
  @HttpCode(204)
  @Delete(':id')
  async delete(@Param('id') id: string) {
    await this.deleteClientUsecase.execute({ id });
  }
}
