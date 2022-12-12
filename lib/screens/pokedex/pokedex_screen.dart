import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/bg_circle.dart';
import 'package:pokemon/routes.dart';
import 'package:pokemon/screens/pokedex/pokedex_item.dart';
import 'package:pokemon/screens/pokedex/pokedex_sheet.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokeColor.lightYellow,
      body: Stack(
        children: [
          ...background(),
          foreground(),
          SafeArea(
            child: IconButton(
              icon: const BackButtonIcon(),
              onPressed: () => context.pop(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> background() {
    return [
      const Align(
        alignment: Alignment(-1, -0.7),
        child: BgCircle(radius: 170),
      ),
      const Align(
        alignment: Alignment(1, 0.7),
        child: BgCircle(radius: 170),
      ),
    ];
  }

  Widget foreground() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          titles(),
          Expanded(child: content()),
        ],
      ),
    );
  }

  Widget titles() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
      child: Column(
        children: [
          Text(
            PokeText.pokedexTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 36,
              color: PokeColor.black,
            ),
          ),
          const SizedBox(height: 16),
          pokedexDesc(999999),
        ],
      ),
    );
  }

  Widget pokedexDesc(int number) {
    return Text(
      PokeText.pokedexDesc.replaceAll('%d', number.toString()),
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(fontSize: 20, color: PokeColor.black),
    );
  }

  Widget content() {
    final pokemons = List.filled(99, _pokemonDummy);
    return ListView.separated(
      padding: const EdgeInsets.all(26),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return PokedexItem(
          key: ObjectKey(pokemon),
          pokemon: pokemon,
          onCardTap: (pokemon) => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(42)),
            ),
            builder: (context) => PokedexSheet(pokemon: pokemon),
          ),
          onTypeTap: (type) => Routes.openTypeScreen(context, type),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 24),
    );
  }
}

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
