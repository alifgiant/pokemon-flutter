import '../core/utils/either.dart';
import 'model/pokemon_model.dart';

abstract class PokemonService {
  const PokemonService();

  Future<Either<Error, PokemonDetailResponse>> getPokemon(
    String name,
  );

  Future<Either<Error, PokemonListResponse>> getPokemons(
    int offset, {
    int limit = 20,
  });

  Future<Either<Error, PokemonListResponse>> getPokemonsByType(
    int offset,
    int id,
  );

  @override
  Future<Either<Error, SpeciesResponse>> getSpecies(String name);

  @override
  Future<Either<Error, EvolutionResponse>> getEvolutionChain(int id);
}
