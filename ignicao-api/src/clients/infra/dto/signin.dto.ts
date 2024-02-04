import { SiginInput } from 'src/clients/application/usecases/signin.usecase';

export class SigninDto implements SiginInput {
  email: string;
  password: string;
}
