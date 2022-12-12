import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/images.dart';
import 'package:pokemon/core/utils/network_poke_image.dart';
import 'package:pokemon/core/utils/string_ext.dart';

class PokedexItem extends StatelessWidget {
  const PokedexItem({
    super.key,
    required this.pokemon,
    required this.onCardTap,
    required this.onTypeTap,
  });

  final Pokemon pokemon;
  final void Function(Pokemon) onCardTap;
  final void Function(PokemonType) onTypeTap;

  @override
  Widget build(BuildContext context) {
    final txtId = pokemon.id.toString().padLeft(3, '0');
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Colors.white,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: NetworkPokeImage(
                  imageUrl: pokemon.imageUrl,
                  height: 220,
                ),
              ),
              Text(
                '#$txtId',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: PokeColor.lightGrey,
                ),
              ),
              Text(
                pokemon.name.toTitleCase(),
                style: GoogleFonts.poppins(
                  fontSize: 24,
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
                        labelStyle: const TextStyle(color: Colors.white),
                        onPressed: () => onTypeTap(e),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        onTap: () => onCardTap(pokemon),
      ),
    );
  }
}
