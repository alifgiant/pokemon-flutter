import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/api/pokemon_api.dart';
import 'package:pokemon/service/local/pokemon_local.dart';

import 'get_pokemon_usecase.dart';

class GetEvolutionUsecase {
  final PokemonLocal local;
  final PokemonApi remote;
  final GetPokemonUsecase _pokemonUsecase;

  GetEvolutionUsecase(this.local, this.remote)
      : _pokemonUsecase = GetPokemonUsecase(local, remote);

  Future<Either<Error, List<Pokemon>>> start(String name) async {
    bool fromLocal = true;
    var response = await local.getSpecies(name);
    if (response.isLeft()) {
      response = await remote.getSpecies(name);
      fromLocal = false;
    }

    if (response.isLeft()) return Left(response.asLeft());
    if (!fromLocal) await local.saveSpecies(name, response.asRight());

    final id = response.asRight().id;

    fromLocal = true;
    var responseChain = await local.getEvolutionChain(id);
    if (responseChain.isLeft()) {
      responseChain = await remote.getEvolutionChain(id);
      fromLocal = false;
    }

    if (responseChain.isLeft()) return Left(responseChain.asLeft());
    if (!fromLocal) await local.saveEvolutionChain(id, responseChain.asRight());

    final detailRequests = responseChain.asRight().species.map(
          (e) => _pokemonUsecase.start(e),
        );
    final pokemonsResult = await Future.wait(detailRequests);
    if (pokemonsResult.any((e) => e.isLeft())) {
      return Left(StateError('Internet Error, Please Retry'));
    }

    return Right(pokemonsResult.map((e) => e.asRight()).toPokeList());
  }
}
