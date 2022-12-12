import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/images.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/string_ext.dart';
import 'package:pokemon/routes.dart';

class PokedexSheet extends StatelessWidget {
  const PokedexSheet({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: PokeColor.lightGrey,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            pokemon.name.toTitleCase(),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
          Center(
            child: CachedNetworkImage(
              imageUrl: pokemon.imageUrl,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: PokeImage.logo.toImage(),
              ),
              height: 270,
            ),
          ),
          itemDetail(PokeText.weight, [pokemon.weight.toString()]),
          const SizedBox(height: 8),
          itemDetail(PokeText.height, [pokemon.height.toString()]),
          const SizedBox(height: 8),
          itemDetail(PokeText.abilities, pokemon.abilities),
          const SizedBox(height: 8),
          itemType(context, PokeText.pokeType, pokemon.pokemonType),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              child: const Text(PokeText.moreDetail),
              onPressed: () => context.push('/detail', extra: pokemon),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDetail(String title, List<String> details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '$title:',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details
              .map(
                (e) => Text(
                  details.length > 1 ? '• $e' : e,
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget itemType(BuildContext ctx, String title, List<PokemonType> types) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            '$title:',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
        Wrap(
          spacing: 6,
          children: types
              .map(
                (e) => ActionChip(
                  label: Text(e.name),
                  labelStyle: const TextStyle(color: Colors.white),
                  backgroundColor: e.color,
                  onPressed: () => Routes.openTypeScreen(ctx, e),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
