import 'package:flutter/material.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/screens/detail/short_detail_view.dart';

class PokedexSheet extends StatelessWidget {
  const PokedexSheet({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 26,
      ),
      child: Column(
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
          ShortDetailView(pokemon: pokemon, showMoreButton: true),
        ],
      ),
    );
  }
}
