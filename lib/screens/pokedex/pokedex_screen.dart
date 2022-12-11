import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/strings.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokeColor.lightYellow,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/type');
        },
      ),
      body: Stack(
        children: [
          // background
          foreground(),
        ],
      ),
    );
  }

  Widget foreground() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Expanded(child: content()),
          ],
        ),
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
    return ListView();
  }
}
