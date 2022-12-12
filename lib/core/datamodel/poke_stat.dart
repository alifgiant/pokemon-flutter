import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/core/res/colors.dart';

class PokeStat extends Equatable {
  final int value;
  final String name;

  const PokeStat(this.value, this.name);

  @override
  List<Object?> get props => [value, name];
}

extension ExtPokeStat on PokeStat {
  Color get color {
    if (value < 60) return PokeColor.fire;
    if (value < 70) return PokeColor.ground;
    if (value < 80) return PokeColor.dark;
    if (value < 90) return PokeColor.fairy;
    return PokeColor.grass;
  }
}
