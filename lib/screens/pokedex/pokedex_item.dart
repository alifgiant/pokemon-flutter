import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/images.dart';

class PokedexItem extends StatelessWidget {
  const PokedexItem({super.key});

  @override
  Widget build(BuildContext context) {
    int id = 1;
    final txtId = id.toString().padLeft(3, '0');
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Colors.white,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [PokeImage.bulbasaur.toImage(height: 220)],
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
                'Poke Name',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: PokeColor.black,
                ),
              ),
              Wrap(
                spacing: 12,
                children: const [
                  Chip(label: Text('Type 1')),
                  Chip(label: Text('Type 2')),
                  Chip(label: Text('Type 3')),
                  Chip(label: Text('Type 4')),
                  Chip(label: Text('Type 5')),
                ],
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
