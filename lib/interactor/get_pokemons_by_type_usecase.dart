import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/service/api/pokemon_api.dart';
import 'package:pokemon/service/local/pokemon_local.dart';
import 'package:pokemon/service/model/pokemon_model.dart';

class GetPokemonByTypeUsecase {
  final PokemonLocal local;
  final PokemonApi remote;

  GetPokemonByTypeUsecase(this.local, this.remote);

  Future<Either<Error, List<Pokemon>>> start({
    required int offset,
    required int typeiId,
  }) async {
    final localData = await local.getPokemonsByType(
      offset,
      PokemonTypeRequest(),
    );
    if (localData.isRight()) {
      return Right(localData.asRight().toPokeList());
    }

    final remoteResponse = await remote.getPokemonsByType(
      offset,
      PokemonTypeRequest(),
    );
    if (remoteResponse.isRight()) {
      await local.savePokemonsByType(offset, typeiId, remoteResponse.asRight());
      return Right(remoteResponse.asRight().toPokeList());
    }

    return Left(StateError('No Result'));
  }
}

extension on PokemonListResponse {
  List<Pokemon> toPokeList() {
    return List.filled(50, _pokemonDummy);
  }
}

const _pokemonDummy = Pokemon(
  1,
  'bulbasaur',
  'https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/001.png',
  9999,
  999,
  [
    PokemonType(1, 'Plant', PokeColor.grass),
    PokemonType(1, 'Steel', PokeColor.grey),
  ],
  [
    'Abilities 1',
    'Abilities 2 (Hidden)',
  ],
);
