import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/network_poke_image.dart';
import 'package:pokemon/core/utils/string_ext.dart';
import 'package:pokemon/routes.dart';

import '../core/utils/bg_circle.dart';
import 'home/poke_app_bar.dart';
import 'home/poke_drawer.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({super.key, required this.pokemonType});

  final PokemonType pokemonType;

  @override
  Widget build(BuildContext context) {
    final pokemons = List.filled(99, _pokemonDummy);
    return Scaffold(
      appBar: const PokeAppBar(),
      endDrawer: const PokeDrawer(),
      body: Stack(
        children: [
          ...background(),
          foreground(pokemons),
        ],
      ),
    );
  }

  List<Widget> background() {
    return [
      Align(
        alignment: const Alignment(-1, -0.7),
        child: BgCircle(
          radius: 170,
          color: pokemonType.color,
        ),
      ),
      Align(
        alignment: const Alignment(1, 0.7),
        child: BgCircle(
          radius: 170,
          color: pokemonType.color,
        ),
      ),
    ];
  }

  Column foreground(List<Pokemon> pokemons) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            PokeText.typeScreenTitle
                .replaceAll('%s', pokemonType.name)
                .toTitleCase(),
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              // ClipRRect(
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(
              //       sigmaX: 7,
              //       sigmaY: 7,
              //     ),
              //     // child: Container(height: 100, width: 100),
              //     child: contents(pokemons),
              //   ),
              // ),
              contents(pokemons),
            ],
          ),
        ),
      ],
    );
  }

  Widget contents(List<Pokemon> pokemons) {
    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        final txtId = pokemon.id.toString().padLeft(3, '0');
        final isFirst = index == 0;
        final isLast = index == pokemons.length - 1;
        return ClipRRect(
          borderRadius: isFirst
              ? const BorderRadius.vertical(top: Radius.circular(24))
              : isLast
                  ? const BorderRadius.vertical(bottom: Radius.circular(24))
                  : BorderRadius.zero,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 7,
              sigmaY: 7,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 21,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NetworkPokeImage(imageUrl: pokemon.imageUrl, width: 75),
                  const SizedBox(width: 10),
                  Container(
                    color: PokeColor.lightGrey,
                    height: 94,
                    width: 1,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#$txtId',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: PokeColor.lightGrey,
                          ),
                        ),
                        Text(
                          pokemon.name.toTitleCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: PokeColor.black,
                          ),
                        ),
                        Wrap(
                          spacing: 12,
                          children: pokemon.pokemonType
                              .map(
                                (e) => ActionChip(
                                  backgroundColor: e.color,
                                  label: Text(e.name.toTitleCase()),
                                  labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  onPressed: () => Routes.openTypeScreen(
                                    context,
                                    e,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
