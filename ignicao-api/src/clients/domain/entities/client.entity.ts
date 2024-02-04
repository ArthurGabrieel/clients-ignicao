import { Entity } from 'src/shared/domain/entities/entity';

export type ClientProps = {
  name: string;
  email: string;
  password: string;
  createdAt?: Date;
};

export class ClientInputEntity extends Entity<ClientProps> {
  constructor(
    public readonly props: ClientProps,
    id?: string,
  ) {
    super(props, id);
    this.props.createdAt = this.props.createdAt ?? new Date();
  }

  update(props: Partial<ClientProps>): void {
    this.props.name = props.name ?? this.props.name;
    this.props.email = props.email ?? this.props.email;
  }

  changePassword(password: string): void {
    this.props.password = password;
  }

  get name(): string {
    return this.props.name;
  }

  get email(): string {
    return this.props.email;
  }

  get password(): string {
    return this.props.password;
  }

  get createdAt(): Date {
    return this.props.createdAt;
  }
}
