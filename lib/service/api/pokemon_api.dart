import 'dart:convert';

import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/model/pokemon_model.dart';
import 'package:http/http.dart' as http;

import '../pokemon_service.dart';

const _rootPath = 'pokeapi.co';

class PokemonApi extends PokemonService {
  @override
  Future<Either<Error, PokemonDetailResponse>> getPokemon(
    int id,
  ) async {
    try {
      final uri = Uri.https(_rootPath, '/api/v2/pokemon/$id');
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
    int offset,
    PokemonTypeRequest typeRequest,
  ) async {
    // return Left(Error());
    return Right(PokemonListResponse(0, []));
  }
}
