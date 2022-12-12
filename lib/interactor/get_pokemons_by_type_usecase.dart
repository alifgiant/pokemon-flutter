import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/api/pokemon_api.dart';
import 'package:pokemon/service/local/pokemon_local.dart';

import 'get_pokemon_usecase.dart';

class GetPokemonByTypeUsecase {
  final PokemonLocal local;
  final PokemonApi remote;
  final GetPokemonUsecase _pokemonUsecase;

  GetPokemonByTypeUsecase(this.local, this.remote)
      : _pokemonUsecase = GetPokemonUsecase(local, remote);

  Future<Either<Error, List<Pokemon>>> start({
    required int offset,
    required int typeId,
  }) async {
    bool fromLocal = true;
    var response = await local.getPokemonsByType(offset, typeId);
    if (response.isLeft()) {
      response = await remote.getPokemonsByType(offset, typeId);
      fromLocal = false;
    }

    if (response.isLeft()) return Left(response.asLeft());
    if (!fromLocal) {
      await local.savePokemonsByType(offset, typeId, response.asRight());
    }

    final detailRequests = response.asRight().pokemons.map(
          (e) => _pokemonUsecase.start(e.id),
        );
    final pokemonsResult = await Future.wait(detailRequests);
    if (pokemonsResult.any((e) => e.isLeft())) {
      return Left(StateError('Internet Error, Please Retry'));
    }

    return Right(pokemonsResult.map((e) => e.asRight()).toPokeList());
  }
}

extension on Iterable<PokemonDetail> {
  List<Pokemon> toPokeList() {
    return map((e) => e.pokemon).toList();
  }
}
