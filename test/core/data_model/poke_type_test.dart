import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';

void main() {
  test('type parsing is correct', () {
    // given
    const typeName = 'fire';

    // when
    final result = PokemonType.parse(typeName);

    // then
    expect(result, PokemonType.fire);
  });
}
