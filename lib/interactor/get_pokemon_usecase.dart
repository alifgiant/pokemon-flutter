import 'package:flutter/material.dart';
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
            .map((e) => PokemonType(e.id, e.name, _getColor(e.name)))
            .toList(),
        abilities,
      ),
      images.toList(),
      pokeStats.map((e) => PokeStat(e.value, e.name)).toList(),
      [], // TODO(alifakbar): evolutions
    );
  }

  Color _getColor(String name) {
    switch (name) {
      case 'normal':
        return PokeColor.normal;
      case 'fighting':
        return PokeColor.fighting;
      case 'flying':
        return PokeColor.flying;
      case 'poison':
        return PokeColor.poison;
      case 'ground':
        return PokeColor.ground;
      case 'rock':
        return PokeColor.rock;
      case 'bug':
        return PokeColor.bug;
      case 'ghost':
        return PokeColor.ghost;
      case 'steel':
        return PokeColor.steel;
      case 'fire':
        return PokeColor.fire;
      case 'water':
        return PokeColor.water;
      case 'grass':
        return PokeColor.grass;
      case 'electric':
        return PokeColor.electric;
      case 'ice':
        return PokeColor.ice;
      case 'dragon':
        return PokeColor.dragon;
      case 'dark':
        return PokeColor.dark;
      case 'fairy':
        return PokeColor.fairy;
      case 'shadow':
        return PokeColor.shadow;
      default:
        return PokeColor.unknown;
    }
  }
}
