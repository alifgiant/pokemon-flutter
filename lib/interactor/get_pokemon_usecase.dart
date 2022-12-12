import 'package:pokemon/core/datamodel/poke_stat.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/api/pokemon_api.dart';
import 'package:pokemon/service/local/pokemon_local.dart';
import 'package:pokemon/service/model/pokemon_model.dart';

class GetPokemonUsecase {
  final PokemonLocal local;
  final PokemonApi remote;

  GetPokemonUsecase(this.local, this.remote);

  Future<Either<Error, PokemonDetail>> start(String name) async {
    final localData = await local.getPokemon(name);
    if (localData.isRight()) {
      return Right(localData.asRight().toPokemonDetail());
    }

    final remoteResponse = await remote.getPokemon(name);
    if (remoteResponse.isRight()) {
      await local.savePokemon(name, remoteResponse.asRight());
      return Right(remoteResponse.asRight().toPokemonDetail());
    }

    return Left(StateError('No Result'));
  }
}

extension on PokemonDetailResponse {
  PokemonDetail toPokemonDetail() {
    return PokemonDetail(
      Pokemon(
        id,
        name,
        images.first,
        weight,
        height,
        pokemonType.map((e) => PokemonType.parse(e.name)).toList(),
        abilities
            .map((e) => "${e.name} ${e.isHidden ? '(hidden)' : ''}")
            .toList(),
      ),
      images.toList(),
      pokeStats.map((e) => PokeStat(e.value, e.name)).toList(),
    );
  }
}
