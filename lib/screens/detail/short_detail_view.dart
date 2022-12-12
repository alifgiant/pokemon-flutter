import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/images.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/network_poke_image.dart';
import 'package:pokemon/core/utils/string_ext.dart';
import 'package:pokemon/routes.dart';

class ShortDetailView extends StatelessWidget {
  const ShortDetailView({
    super.key,
    required this.pokemon,
    this.showMoreButton = false,
  });

  final Pokemon pokemon;
  final bool showMoreButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pokemon.name.toTitleCase(),
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 36),
        ),
        Center(
          child: NetworkPokeImage(
            imageUrl: pokemon.imageUrl,
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
        if (showMoreButton) const SizedBox(height: 32),
        if (showMoreButton)
          Center(
            child: ElevatedButton(
              child: const Text(PokeText.moreDetail),
              onPressed: () => context.push('/detail', extra: pokemon),
            ),
          ),
      ],
    );
  }

  Widget itemDetail(String title, List<String> details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: sectionTitle(title)),
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
        Expanded(child: sectionTitle(title)),
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

  static Widget sectionTitle(String title) {
    return Text(
      '$title:',
      style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16),
    );
  }
}
