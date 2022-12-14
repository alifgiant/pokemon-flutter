import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/model/pokemon_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pokemon_service.dart';

class PokemonLocal extends PokemonService {
  final SharedPreferences pref;

  const PokemonLocal(this.pref);

  @override
  Future<Either<Error, PokemonDetailResponse>> getPokemon(
    String name,
  ) async {
    final key = 'pokemon#$name';
    final savedString = pref.getString(key);
    if (savedString == null) return Left(StateError('No Cache'));

    final json = jsonDecode(savedString);
    if (json is! Map<String, dynamic>) return Left(StateError('Not valid'));

    final expireTimeStr = int.parse(json[key]);
    final expireTime = DateTime.fromMillisecondsSinceEpoch(expireTimeStr);

    final now = clock.now();
    if (now.isAfter(expireTime)) return Left(StateError('Expire'));

    return Right(PokemonDetailResponse.fromJson(json));
  }

  Future savePokemon(String name, PokemonDetailResponse pokemonResponse) async {
    final json = pokemonResponse.toJson();

    final key = 'pokemon#$name';
    final now = clock.now().add(const Duration(days: 1));
    json[key] = now.millisecondsSinceEpoch.toString(); // add expire time

    await pref.setString(key, jsonEncode(json));
  }

  @override
  Future<Either<Error, PokemonListResponse>> getPokemons(
    int offset, {
    int limit = 20,
  }) async {
    final key = 'pokemons#$offset#$limit';
    final savedString = pref.getString(key);
    if (savedString == null) return Left(StateError('No Cache'));

    final json = jsonDecode(savedString);
    if (json is! Map<String, dynamic>) return Left(StateError('Not valid'));

    final expireTimeStr = int.parse(json[key]);
    final expireTime = DateTime.fromMillisecondsSinceEpoch(expireTimeStr);

    final now = clock.now();
    if (now.isAfter(expireTime)) return Left(StateError('Expire'));

    return Right(PokemonListResponse.fromJson(json));
  }

  Future savePokemons(
    int offset,
    PokemonListResponse pokemonResponse, {
    int limit = 20,
  }) async {
    final json = pokemonResponse.toJson();

    final key = 'pokemons#$offset#$limit';
    final now = clock.now().add(const Duration(days: 1));
    json[key] = now.millisecondsSinceEpoch.toString(); // add expire time

    await pref.setString(key, jsonEncode(json));
  }

  @override
  Future<Either<Error, PokemonListResponse>> getPokemonsByType(
    int offset, // unused
    int id,
  ) async {
    final key = 'type#$offset#$id';
    final savedString = pref.getString(key);
    if (savedString == null) return Left(StateError('No Cache'));

    final json = jsonDecode(savedString);
    if (json is! Map<String, dynamic>) return Left(StateError('Not valid'));

    final expireTimeStr = int.parse(json[key]);
    final expireTime = DateTime.fromMillisecondsSinceEpoch(expireTimeStr);

    final now = clock.now();
    if (now.isAfter(expireTime)) return Left(StateError('Expire'));

    return Right(PokemonListResponse.fromJson(json));
  }

  Future savePokemonsByType(
    int offset,
    int id,
    PokemonListResponse pokemonResponse,
  ) async {
    final json = pokemonResponse.toJson();

    final key = 'type#$offset#$id';
    final now = clock.now().add(const Duration(days: 1));
    json[key] = now.millisecondsSinceEpoch.toString(); // add expire time

    await pref.setString(key, jsonEncode(json));
  }

  @override
  Future<Either<Error, EvolutionResponse>> getEvolutionChain(int id) async {
    final key = 'evolution#$id';
    final savedString = pref.getString(key);
    if (savedString == null) return Left(StateError('No Cache'));

    final json = jsonDecode(savedString);
    if (json is! Map<String, dynamic>) return Left(StateError('Not valid'));

    final expireTimeStr = int.parse(json[key]);
    final expireTime = DateTime.fromMillisecondsSinceEpoch(expireTimeStr);

    final now = clock.now();
    if (now.isAfter(expireTime)) return Left(StateError('Expire'));

    return Right(EvolutionResponse.fromJson(json));
  }

  Future saveEvolutionChain(
    int id,
    EvolutionResponse pokemonResponse,
  ) async {
    final json = pokemonResponse.toJson();

    final key = 'evolution#$id';
    final now = clock.now().add(const Duration(days: 1));
    json[key] = now.millisecondsSinceEpoch.toString(); // add expire time

    await pref.setString(key, jsonEncode(json));
  }

  @override
  Future<Either<Error, SpeciesResponse>> getSpecies(String name) async {
    final key = 'species#$name';
    final savedString = pref.getString(key);
    if (savedString == null) return Left(StateError('No Cache'));

    final json = jsonDecode(savedString);
    if (json is! Map<String, dynamic>) return Left(StateError('Not valid'));

    final expireTimeStr = int.parse(json[key]);
    final expireTime = DateTime.fromMillisecondsSinceEpoch(expireTimeStr);

    final now = clock.now();
    if (now.isAfter(expireTime)) return Left(StateError('Expire'));

    return Right(SpeciesResponse.fromJson(json));
  }

  Future saveSpecies(
    String name,
    SpeciesResponse pokemonResponse,
  ) async {
    final json = pokemonResponse.toJson();

    final key = 'species#$name';
    final now = clock.now().add(const Duration(days: 1));
    json[key] = now.millisecondsSinceEpoch.toString(); // add expire time

    await pref.setString(key, jsonEncode(json));
  }
}
