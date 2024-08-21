import 'package:dependencies/dependencies.dart' show Equatable;
import 'package:test/test.dart';

class NormaEquality {
  const NormaEquality(this.value);
  final String value;
}

@Equatable()
class Equality {
  const Equality(this.value);
  final String value;
}

void main() {
  group('Equality', () {
    test('should return true when two objects with the same value are compared',
        () {
      final Map<Object, int> data = <Object, int>{};
      data[Equality("abc")] = 1;

      final isThere = data.containsKey(Equality("abc"));

      expect(isThere, isTrue);
    });

    test(
        'should return false when two objects with different values are compared',
        () {
      final Map<Object, int> data = <Object, int>{};
      data[Equality("abc")] = 1;

      final isThere = data.containsKey(Equality("xyz"));

      expect(isThere, isFalse);
    });
  });
  group('NormaEquality', () {
    test('should return true when two objects with the same value are compared',
        () {
      final Map<Object, int> data = <Object, int>{};
      data[NormaEquality("abc")] = 1;

      final isThere = data.containsKey(NormaEquality("abc"));

      expect(isThere, isFalse);
    });
  });
}
