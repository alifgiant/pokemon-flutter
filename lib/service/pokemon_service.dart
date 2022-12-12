import '../core/utils/either.dart';
import 'model/pokemon_model.dart';

abstract class PokemonService {
  Future<Either<Error, PokemonDetailResponse>> getPokemon(
    int id,
  );

  Future<Either<Error, PokemonResponse>> getPokemons(
    int offset,
  );

  Future<Either<Error, PokemonResponse>> getPokemonsByType(
    int offset,
    PokemonTypeRequest typeRequest,
  );
}
