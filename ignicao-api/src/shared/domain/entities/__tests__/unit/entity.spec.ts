import { validate } from 'uuid';
import { Entity } from '../../entity';

type StubProps = {
  prop1: string;
  prop2: number;
};

class StubEntity extends Entity<StubProps> {}

describe('Entity unit tests', () => {
  it('should create a new entity', () => {
    const props = { prop1: 'test', prop2: 1 };
    const entity = new StubEntity(props);

    expect(entity).toBeInstanceOf(StubEntity);
    expect(entity._id).not.toBeNull();
    expect(validate(entity._id)).toBeTruthy();
    expect(entity.props).toStrictEqual(props);
  });

  it('should accept a valid uuid', () => {
    const props = { prop1: 'test', prop2: 1 };
    const id = 'e18dd873-d1c2-4d63-8ce6-6a7df3cadbaf';
    const entity = new StubEntity(props, id);

    expect(entity._id).toEqual(id);
    expect(validate(entity._id)).toBeTruthy();
  });

  it('should not accept an invalid uuid', () => {
    const props = { prop1: 'test', prop2: 1 };
    const id = 'invalid-uuid';
    const entity = new StubEntity(props, id);

    expect(validate(entity._id)).toBeFalsy();
  });

  it('should convert an entity to a json', () => {
    const props = { prop1: 'test', prop2: 1 };
    const id = 'e18dd873-d1c2-4d63-8ce6-6a7df3cadbaf';
    const entity = new StubEntity(props, id);

    expect(entity.toJson()).toStrictEqual({ id, ...props });
  });
});
