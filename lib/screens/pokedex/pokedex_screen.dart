import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/screens/pokedex/pokedex_item.dart';

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
    return ListView.separated(
      padding: const EdgeInsets.all(26),
      itemCount: 99,
      itemBuilder: (context, index) {
        return const PokedexItem();
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 24);
      },
    );
  }
}
