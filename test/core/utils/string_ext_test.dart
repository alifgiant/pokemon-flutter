import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/core/utils/string_ext.dart';

void main() {
  test('titleCase is correct', () {
    const test1 = '';
    expect(test1.toTitleCase(), '');

    const test2 = 'a';
    expect(test2.toTitleCase(), 'A');

    const test3 = 'alif akbar';
    expect(test3.toTitleCase(), 'Alif Akbar');

    const test4 = 'alif (akbar)';
    expect(test4.toTitleCase(), 'Alif (akbar)');
  });

  test('toPokeId is correct', () {
    const test1 = 1;
    expect(test1.toPokeId(), '#0001');

    const test2 = 11;
    expect(test2.toPokeId(), '#0011');

    const test3 = 111;
    expect(test3.toPokeId(), '#0111');

    const test4 = 1111;
    expect(test4.toPokeId(), '#1111');
  });
}
