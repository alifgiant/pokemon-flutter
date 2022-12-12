import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon/core/utils/either.dart';
import 'package:pokemon/interactor/get_pokemon_usecase.dart';
import 'package:pokemon/service/api/pokemon_api.dart';
import 'package:pokemon/service/local/pokemon_local.dart';
import 'package:pokemon/service/model/pokemon_model.dart';

void main() {
  test('when local data exist return local data', () async {
    // when
    const pokeName = 'name';
    final local = MockLocal();
    when(local.getPokemon(pokeName)).thenAnswer(
      (_) async => Right(
        PokemonDetailResponse(1, pokeName, 1, 1, [], [], [], [], []),
      ),
    );
    final remote = MockRemote();
    final usecase = GetPokemonUsecase(local, remote);

    // when
    final result = await usecase.start(pokeName);

    expect(result.asRight().pokemon.name, pokeName);
  });
}

class MockLocal extends Mock implements PokemonLocal {}

class MockRemote extends Mock implements PokemonApi {}
