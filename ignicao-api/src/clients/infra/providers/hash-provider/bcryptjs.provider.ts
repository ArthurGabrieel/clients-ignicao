import { compare, hash } from 'bcryptjs';
import { HashProvider } from 'src/shared/application/providers/hash-provider';

export class BcryptjsHashProvider implements HashProvider {
  async generateHash(payload: string) {
    return hash(payload, 8);
  }

  async compare(payload: string, hash: string) {
    return compare(payload, hash);
  }
}
