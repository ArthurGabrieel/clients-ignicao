import { SignupInput } from 'src/clients/application/usecases/signup.usecase';

export class SignupDto implements SignupInput {
  name: string;
  email: string;
  password: string;
}
