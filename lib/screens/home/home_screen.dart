import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/images.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/page_switcher_builder.dart';
import 'package:pokemon/screens/home/poke_app_bar.dart';
import 'package:pokemon/screens/home/poke_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSwitcherBuilder(
      builder: (controller) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(0, -1.0),
          ).animate(controller),
          child: Scaffold(
            appBar: const PokeAppBar(),
            endDrawer: const PokeDrawer(selectedMenu: PokeText.home),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image(screenWidth: MediaQuery.of(context).size.width),
                  ...contents,
                  const SizedBox(height: 24),
                  ElevatedButton(
                    child: const Text(PokeText.welcomeButton),
                    onPressed: () => context.push(
                      '/pokedex',
                      extra: controller,
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

  Widget image({required double screenWidth}) {
    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-0.6, -0.6),
            child: PokeImage.squirtle.toImage(width: screenWidth / 2.5),
          ),
          Align(
            alignment: Alignment.center,
            child: PokeImage.bulbasaur.toImage(width: screenWidth / 2.5),
          ),
          Align(
            alignment: const Alignment(0.6, 0.6),
            child: PokeImage.charmender.toImage(width: screenWidth / 2.5),
          ),
        ],
      ),
    );
  }

  List<Widget> get contents {
    return [
      Text(
        PokeText.heroText,
        style: GoogleFonts.poppins(
          fontSize: 40,
          height: 1.11,
          fontWeight: FontWeight.w700,
          color: PokeColor.black,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        PokeText.welcomeDesc,
        style: GoogleFonts.poppins(
          fontSize: 20,
          height: 1.5,
          color: PokeColor.grey,
        ),
      ),
    ];
  }
}
