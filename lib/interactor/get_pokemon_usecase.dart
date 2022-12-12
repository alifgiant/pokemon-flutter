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
    return _pokemonDetail;
  }
}

final _pokemonDetail = PokemonDetail(
  _pokemonDummy,
  List.filled(5, _pokemonDummy.imageUrl),
  List.filled(5, const PokeStat(67, 'Fight', PokeColor.fire)),
  List.filled(5, _pokemonDummy),
);

const _pokemonDummy = Pokemon(
  1,
  'bulbasaur',
  'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/001.png',
  9999,
  999,
  [
    PokemonType(1, 'Plant', PokeColor.plant),
    PokemonType(1, 'Steel', PokeColor.grey),
  ],
  [
    'Abilities 1',
    'Abilities 2 (Hidden)',
  ],
);
