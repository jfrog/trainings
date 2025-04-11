const sum = require('../frog-util').sum;
const greet = require('../frog-util').frogGreet;

describe('sum module', () => {
    test('adds 1 + 2 to equal 3', () => {
      expect(sum(1, 2)).toBe(3);
    });
  });

  describe('greet module', () => {
    test('adds 🐸 ', () => {
      expect(greet('testing')).toEqual('testing 🐸');
    });
  });