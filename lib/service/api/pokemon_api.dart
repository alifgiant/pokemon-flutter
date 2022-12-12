import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/model/pokemon_model.dart';

import '../pokemon_service.dart';

class PokemonApi extends PokemonService {
  @override
  Future<Either<Error, PokemonDetailResponse>> getPokemon(
    int id,
  ) async {
    return Right(PokemonDetailResponse());
  }

  @override
  Future<Either<Error, PokemonResponse>> getPokemons(
    int offset,
  ) async {
    return Right(PokemonResponse());
  }

  @override
  Future<Either<Error, PokemonResponse>> getPokemonsByType(
    int offset,
    PokemonTypeRequest typeRequest,
  ) async {
    return Left(Error());
  }
}
