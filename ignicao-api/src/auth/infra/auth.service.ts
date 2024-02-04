import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

type GenerateTokenProps = {
  accessToken: string;
};

@Injectable()
export class AuthService {
  constructor(private readonly jwtService: JwtService) {}

  async generateToken(clientId: string): Promise<GenerateTokenProps> {
    const accessToken = await this.jwtService.signAsync({ id: clientId });

    return { accessToken };
  }

  async verifyToken(token: string) {
    return this.jwtService.verifyAsync(token, {
      secret: 'ignicao_secret',
    });
  }
}
