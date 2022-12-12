import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon/core/datamodel/poke_stat.dart';
import 'package:pokemon/core/res/colors.dart';

void main() {
  test('check color is correct', () {
    Color color = const PokeStat(10, 'name').color;
    expect(color, PokeColor.fire);

    color = const PokeStat(66, 'name').color;
    expect(color, PokeColor.ground);

    color = const PokeStat(76, 'name').color;
    expect(color, PokeColor.dark);

    color = const PokeStat(86, 'name').color;
    expect(color, PokeColor.fairy);

    color = const PokeStat(99, 'name').color;
    expect(color, PokeColor.grass);
  });
}
