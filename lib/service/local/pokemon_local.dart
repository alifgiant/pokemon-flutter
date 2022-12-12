import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/model/pokemon_model.dart';

import '../pokemon_service.dart';

class PokemonLocal extends PokemonService {
  @override
  Future<Either<Error, PokemonDetailResponse>> getPokemon(
    int id,
  ) async {
    return Left(Error());
  }

  Future savePokemon(int id, PokemonDetailResponse pokemonResponse) async {
    // TODO(alifakbar): save pokemon
  }

  @override
  Future<Either<Error, PokemonListResponse>> getPokemons(
    int offset, {
    int limit = 20,
  }) async {
    return Left(Error());
  }

  Future savePokemons(int offset, PokemonListResponse pokemonResponse) async {
    // TODO(alifakbar): save pokemons
  }

  @override
  Future<Either<Error, PokemonListResponse>> getPokemonsByType(
    int offset,
    PokemonTypeRequest typeRequest,
  ) async {
    return Left(Error());
  }

  Future savePokemonsByType(
    int offset,
    int id,
    PokemonListResponse pokemonResponse,
  ) async {
    // TODO(alifakbar): save pokemons
  }
}
