import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/model/pokemon_model.dart';

import '../pokemon_service.dart';

const _rootPath = 'pokeapi.co';

class PokemonApi extends PokemonService {
  @override
  Future<Either<Error, PokemonDetailResponse>> getPokemon(
    String name,
  ) async {
    try {
      final uri = Uri.https(_rootPath, '/api/v2/pokemon/$name');
      final rawResult = await http.get(uri);
      final rawJson = jsonDecode(rawResult.body);

      return Right(PokemonDetailResponse.fromJson(rawJson));
    } catch (e) {
      return Left(StateError('Internet Error, Retry Please'));
    }
  }

  @override
  Future<Either<Error, PokemonListResponse>> getPokemons(
    int offset, {
    int limit = 20,
  }) async {
    try {
      final uri = Uri.https(
        _rootPath,
        '/api/v2/pokemon',
        {'limit': limit.toString(), 'offset': offset.toString()},
      );
      final rawResult = await http.get(uri);
      final rawJson = jsonDecode(rawResult.body);

      return Right(PokemonListResponse.fromJson(rawJson));
    } catch (e) {
      return Left(StateError('Internet Error, Retry Please'));
    }
  }

  @override
  Future<Either<Error, PokemonListResponse>> getPokemonsByType(
    int offset, // unused
    int id,
  ) async {
    try {
      final uri = Uri.https(_rootPath, '/api/v2/type/$id');
      final rawResult = await http.get(uri);
      final rawJson = jsonDecode(rawResult.body);
      final pokemons = (rawJson['pokemon'] as List)
          .map(
            (e) => e['pokemon'],
          )
          .toList();
      return Right(PokemonListResponse.fromJson({'results': pokemons}));
    } catch (e) {
      return Left(StateError('Internet Error, Retry Please'));
    }
  }
}
