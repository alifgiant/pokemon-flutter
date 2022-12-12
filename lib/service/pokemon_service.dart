import '../core/utils/either.dart';
import 'model/pokemon_model.dart';

abstract class PokemonService {
  const PokemonService();

  Future<Either<Error, PokemonDetailResponse>> getPokemon(
    int id,
  );

  Future<Either<Error, PokemonListResponse>> getPokemons(
    int offset, {
    int limit = 20,
  });

  Future<Either<Error, PokemonListResponse>> getPokemonsByType(
    int offset,
    int id,
  );
}
