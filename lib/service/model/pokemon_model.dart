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
  final String id;

  PokemonResponse(this.name, this.id);

  factory PokemonResponse.fromJson(Map<String, dynamic> json) {
    final url = json['url'].toString();
    final id = PokeRegex.pokemonId.firstMatch(url)?.group(0);
    return PokemonResponse(
      json['name'].toString(),
      id ?? '0',
    );
  }
}

class PokemonDetailResponse {}
