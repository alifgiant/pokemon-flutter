import 'package:pokemon/service/model/poke_regex.dart';

class PokemonListResponse {
  final int count;
  final List<PokemonResponse> pokemons;

  PokemonListResponse(this.count, this.pokemons);

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    final pokeList = json['results'] as List;
    return PokemonListResponse(
      json['count'] ?? pokeList.length,
      pokeList.map((e) => PokemonResponse.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'results': pokemons.map((e) => e.toJson()).toList(),
      };
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

  Map<String, dynamic> toJson() => {'name': name, 'url': '/$id'};
}

class PokemonDetailResponse {
  final int id;
  final String name;
  final int weight, height;
  final List<PokemonTypeResponse> pokemonType;
  final List<PokemonAbilityRespinse> abilities;
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
          .map((e) => PokemonAbilityRespinse.fromJson(e))
          .toList(),
      {
        json['sprites']['other']['official-artwork']['front_default']
            .toString(),
        ...iterateImage(json['sprites']),
      }.toList(),
      (json['stats'] as List)
          .map((e) => PokemonStatResponse.fromJson(e))
          .toList(),
      [], // TODO(alifakbar): evolutions
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'height': height,
      'types': pokemonType.map((e) => {'type': e.toJson()}).toList(),
      'abilities': abilities.map((e) => e.toJson()).toList(),
      'sprites': {
        'other': {
          'official-artwork': {
            'front_default': images.first,
          }
        },
        ...images.asMap().map((key, value) => MapEntry(key.toString(), value))
      },
      'stats': pokeStats.map((e) => e.toJson()).toList()
    };
  }

  static Set<String> iterateImage(Map<String, dynamic> json) {
    Set<String> images = {};
    for (final value in json.values) {
      if (value is String && value.endsWith('.png')) {
        images.add(value);
      } else if (value is Map<String, dynamic>) {
        images.addAll(iterateImage(value));
      }
    }
    return images;
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

  Map<String, dynamic> toJson() => {'name': name, 'url': '/$id'};
}

class PokemonAbilityRespinse {
  final String name;
  final bool isHidden;

  PokemonAbilityRespinse(this.name, this.isHidden);

  factory PokemonAbilityRespinse.fromJson(Map<String, dynamic> json) {
    return PokemonAbilityRespinse(
      json['ability']['name'],
      json['is_hidden'] == true,
    );
  }

  Map<String, dynamic> toJson() => {
        'ability': {'name': name},
        'is_hidden': isHidden
      };
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

  Map<String, dynamic> toJson() => {
        'stat': {'name': name},
        'base_stat': value
      };
}

class SpeciesResponse {
  final int id;

  SpeciesResponse(this.id);

  factory SpeciesResponse.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return SpeciesResponse(-1);

    final id = json['url'].toString().getId();
    return SpeciesResponse(int.parse(id));
  }

  Map<String, dynamic> toJson() => {'url': '/$id'};
}

class EvolutionResponse {
  final List<String> species;

  EvolutionResponse(this.species);

  factory EvolutionResponse.fromJson(Map<String, dynamic> json) {
    List<String> pokemons = iterateEvolution(json);

    return EvolutionResponse(pokemons);
  }

  static List<String> iterateEvolution(Map<String, dynamic> json) {
    List<String> pokemons = List.empty(growable: true);
    pokemons.add(json['species']['name']);

    final evolveTo = json['evolves_to'] as List;
    if (evolveTo.isEmpty) return pokemons;

    pokemons.addAll(iterateEvolution(evolveTo.first));
    return pokemons;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>? all;
    Map<String, dynamic>? prev;

    for (final pokemon in species) {
      final data = <String, dynamic>{
        'species': {'name': pokemon},
        'evolves_to': [],
      };
      all ??= data;

      if (prev != null) prev['evolves_to'] = [data];
      prev = data;
    }
    return all ?? {};
  }
}
