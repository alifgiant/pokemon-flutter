import 'package:pokemon/service/model/poke_regex.dart';

class PokemonTypeRequest {}

class PokemonListResponse {
  final int count;
  final List<PokemonResponse> pokemons;

  PokemonListResponse(this.count, this.pokemons);

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    final pokeList = json['results'] as List;
    return PokemonListResponse(
      json['count'],
      pokeList.map((e) => PokemonResponse.fromJson(e)).toList(),
    );
  }
}

class PokemonResponse {
  final String name;
  final int id;

  PokemonResponse(this.name, this.id);

  factory PokemonResponse.fromJson(Map<String, dynamic> json) {
    final id = json['url'].toString().getId();
    return PokemonResponse(
      json['name'].toString(),
      int.parse(id),
    );
  }
}

class PokemonDetailResponse {
  final int id;
  final String name;
  final int weight, height;
  final List<PokemonTypeResponse> pokemonType;
  final List<String> abilities;
  final List<String> images;
  final List<PokemonStatResponse> pokeStats;
  final List<String> evolutionsId;

  PokemonDetailResponse(
    this.id,
    this.name,
    this.weight,
    this.height,
    this.pokemonType,
    this.abilities,
    this.images,
    this.pokeStats,
    this.evolutionsId,
  );

  factory PokemonDetailResponse.fromJson(Map<String, dynamic> json) {
    return PokemonDetailResponse(
      json['id'],
      json['name'],
      json['weight'],
      json['height'],
      (json['types'] as List)
          .map((e) => PokemonTypeResponse.fromJson(e['type']))
          .toList(),
      (json['abilities'] as List)
          .map(
            (e) =>
                "${e['ability']['name']} ${e['is_hidden'] ? '(hidden)' : ''}",
          )
          .toList(),
      [json['sprites']['other']['official-artwork']['front_default']],
      (json['stats'] as List)
          .map((e) => PokemonStatResponse.fromJson(e))
          .toList(),
      [], // TODO(alifakbar): evolutions
    );
  }
}

class PokemonTypeResponse {
  final String name;
  final int id;

  PokemonTypeResponse(this.name, this.id);

  factory PokemonTypeResponse.fromJson(Map<String, dynamic> json) {
    final id = json['url'].toString().getId();
    return PokemonTypeResponse(
      json['name'],
      int.parse(id),
    );
  }
}

class PokemonStatResponse {
  final String name;
  final int value;

  PokemonStatResponse(this.name, this.value);

  factory PokemonStatResponse.fromJson(Map<String, dynamic> json) {
    return PokemonStatResponse(
      json['stat']['name'],
      int.parse(json['base_stat'].toString()),
    );
  }
}
