import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/model/pokemon_model.dart';

import '../pokemon_service.dart';

class PokemonLocal extends PokemonService {
  @override
  Future<Either<Error, PokemonDetailResponse>> getPokemon(
    int id,
  ) async {
    return Right(PokemonDetailResponse());
  }

  Future savePokemon(int id, PokemonDetailResponse pokemonResponse) async {
    // TODO(alifakbar): save pokemon
  }

  @override
  Future<Either<Error, PokemonResponse>> getPokemons(
    int offset,
  ) async {
    return Right(PokemonResponse());
  }

  Future savePokemons(int offset, PokemonResponse pokemonResponse) async {
    // TODO(alifakbar): save pokemons
  }

  @override
  Future<Either<Error, PokemonResponse>> getPokemonsByType(
    int offset,
    PokemonTypeRequest typeRequest,
  ) async {
    return Left(Error());
  }
}
