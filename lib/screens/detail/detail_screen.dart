import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/datamodel/poke_stat.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/images.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/network_poke_image.dart';
import 'package:pokemon/core/utils/string_ext.dart';
import 'package:pokemon/screens/detail/short_detail_view.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.pokemon});

  final Pokemon pokemon;
  final PokemonDetail pokemonDetail = _pokemonDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PokeImage.logo.toImage(),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
        children: [
          ShortDetailView(pokemon: pokemon),
          const SizedBox(height: 32),
          ShortDetailView.sectionTitle(PokeText.otherImages),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 21,
            runSpacing: 10,
            children: _pokemonDetail.otherImages
                .map((e) => NetworkPokeImage(imageUrl: e, width: 100))
                .toList(),
          ),
          const SizedBox(height: 32),
          ShortDetailView.sectionTitle(PokeText.stat),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 21,
            runSpacing: 21,
            children: _pokemonDetail.pokeStats.map((e) => itemStat(e)).toList(),
          ),
          const SizedBox(height: 32),
          ShortDetailView.sectionTitle(PokeText.evolution),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 21,
            runSpacing: 21,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final evo in _pokemonDetail.evolutions.asMap().entries) ...[
                itemEvolution(evo.key, evo.value),
                if (evo.key != _pokemonDetail.evolutions.length - 1)
                  const Icon(Icons.arrow_right_alt_rounded),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget itemStat(PokeStat stat, {double size = 90}) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: stat.value / 100,
              strokeWidth: 6,
              color: stat.color,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  stat.value.toString(),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: stat.color,
                  ),
                ),
                Text(
                  stat.name.toTitleCase(),
                  style: GoogleFonts.poppins(fontSize: 14, color: stat.color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemEvolution(
    int index,
    Pokemon pokemon, {
    double size = 100,
  }) {
    Color color = PokeColor.black;
    switch (index) {
      case 0:
        color = PokeColor.plant;
        break;
      case 1:
        color = PokeColor.yellow;
        break;
      case 2:
        color = PokeColor.water;
        break;
      case 3:
        color = PokeColor.fire;
        break;
    }
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 6,
                  color: color,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: NetworkPokeImage(
                  imageUrl: pokemon.imageUrl,
                  width: 70,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          pokemon.name.toTitleCase(),
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: color,
          ),
        ),
      ],
    );
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
