import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PokemonType extends Equatable {
  final int id;
  final String name;
  final Color color;

  const PokemonType(this.id, this.name, this.color);

  @override
  List<Object?> get props => [id, name, color];
}
