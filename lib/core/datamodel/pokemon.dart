import 'package:equatable/equatable.dart';
import 'package:pokemon/core/datamodel/poke_stat.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';

class Pokemon extends Equatable {
  final int id;
  final String name, imageUrl;
  final int weight, height;
  final List<PokemonType> pokemonType;
  final List<String> abilities;

  const Pokemon(
    this.id,
    this.name,
    this.imageUrl,
    this.weight,
    this.height,
    this.pokemonType,
    this.abilities,
  );

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        pokemonType,
        ...abilities,
      ];
}

class PokemonDetail extends Equatable {
  final Pokemon pokemon;
  final List<String> otherImages;
  final List<PokeStat> pokeStats;
  final List<Pokemon> evolutions;

  const PokemonDetail(
    this.pokemon,
    this.otherImages,
    this.pokeStats,
    this.evolutions,
  );

  @override
  List<Object?> get props =>
      [pokemon, ...otherImages, ...pokeStats, ...evolutions];
}
