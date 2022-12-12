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

  const PokemonDetail(
    this.pokemon,
    this.otherImages,
    this.pokeStats,
  );

  @override
  List<Object?> get props => [
        pokemon,
        ...otherImages,
        ...pokeStats,
      ];
}

extension ExtPokemonDetail on Iterable<PokemonDetail> {
  List<Pokemon> toPokeList() {
    return map((e) => e.pokemon).toList();
  }
}
