import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PokeStat extends Equatable {
  final int value;
  final String name;
  final Color color;

  const PokeStat(this.value, this.name, this.color);

  @override
  List<Object?> get props => [value, name, color];
}
