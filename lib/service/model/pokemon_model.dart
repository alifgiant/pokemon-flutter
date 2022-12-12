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

  Map<String, dynamic> toJson() => {
        'count': count,
        'results': pokemons.map((e) => e.toJson()).toList(),
      };
}

class PokemonResponse {
  final String name;
  final int id;
  final String _url;

  PokemonResponse(this.name, this.id, this._url);

  factory PokemonResponse.fromJson(Map<String, dynamic> json) {
    final id = json['url'].toString().getId();
    return PokemonResponse(
      json['name'].toString(),
      int.parse(id),
      json['url'],
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'url': _url};
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
  final String _url;

  PokemonTypeResponse(this.name, this.id, this._url);

  factory PokemonTypeResponse.fromJson(Map<String, dynamic> json) {
    final id = json['url'].toString().getId();
    return PokemonTypeResponse(
      json['name'],
      int.parse(id),
      json['url'],
    );
  }

  Map<String, dynamic> toJson() => {'name': name, 'id': id, 'url': _url};
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
