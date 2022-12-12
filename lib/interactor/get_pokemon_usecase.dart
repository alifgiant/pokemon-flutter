import 'package:pokemon/core/datamodel/poke_stat.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/api/pokemon_api.dart';
import 'package:pokemon/service/local/pokemon_local.dart';
import 'package:pokemon/service/model/pokemon_model.dart';

class GetPokemonUsecase {
  final PokemonLocal local;
  final PokemonApi remote;

  GetPokemonUsecase(this.local, this.remote);

  Future<Either<Error, PokemonDetail>> start(int id) async {
    final localData = await local.getPokemon(id);
    if (localData.isRight()) {
      return Right(localData.asRight().toPokemonDetail());
    }

    final remoteResponse = await remote.getPokemon(id);
    if (remoteResponse.isRight()) {
      await local.savePokemon(id, remoteResponse.asRight());
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
        pokemonType
            .map((e) => PokemonType(e.id, e.name, PokeColor.fire))
            .toList(),
        abilities,
      ),
      images,
      pokeStats.map((e) => PokeStat(e.value, e.name, PokeColor.fire)).toList(),
      [], // TODO(alifakbar): evolutions
    );
  }
}
