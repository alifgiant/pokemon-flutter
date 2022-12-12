import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/core/res/colors.dart';

class PokemonType extends Equatable {
  final int id;
  final String name;
  final Color color;

  const PokemonType(this.id, this.name, this.color);

  @override
  List<Object?> get props => [id, name];

  static const normal = PokemonType(1, 'normal', PokeColor.normal);
  static const fighting = PokemonType(2, 'fighting', PokeColor.fighting);
  static const flying = PokemonType(3, 'flying', PokeColor.flying);
  static const poison = PokemonType(4, 'poison', PokeColor.poison);
  static const ground = PokemonType(5, 'ground', PokeColor.ground);
  static const rock = PokemonType(6, 'rock', PokeColor.rock);
  static const bug = PokemonType(7, 'bug', PokeColor.bug);
  static const ghost = PokemonType(8, 'ghost', PokeColor.ghost);
  static const steel = PokemonType(9, 'steel', PokeColor.steel);
  static const fire = PokemonType(10, 'fire', PokeColor.fire);
  static const water = PokemonType(11, 'water', PokeColor.water);
  static const grass = PokemonType(12, 'grass', PokeColor.grass);
  static const electric = PokemonType(13, 'electric', PokeColor.electric);
  static const psychic = PokemonType(14, 'psychic', PokeColor.psychic);
  static const ice = PokemonType(15, 'ice', PokeColor.ice);
  static const dragon = PokemonType(16, 'dragon', PokeColor.dragon);
  static const dark = PokemonType(17, 'dark', PokeColor.dark);
  static const fairy = PokemonType(18, 'fairy', PokeColor.fairy);
  static const unknown = PokemonType(10001, 'unknown', PokeColor.unknown);
  static const shadow = PokemonType(10002, 'shadow', PokeColor.shadow);

  static const all = [
    normal,
    fighting,
    flying,
    poison,
    ground,
    rock,
    bug,
    ghost,
    steel,
    fire,
    water,
    grass,
    electric,
    psychic,
    ice,
    dragon,
    dark,
    fairy,
    unknown,
    shadow,
  ];

  factory PokemonType.parse(String name) {
    return all.firstWhere((element) => element.name == name);
  }
}
