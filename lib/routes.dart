import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/screens/detail/detail_screen.dart';
import 'package:pokemon/screens/home/home_screen.dart';
import 'package:pokemon/screens/pokedex/pokedex_screen.dart';
import 'package:pokemon/screens/type_screen.dart';

import 'core/datamodel/poke_type.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/pokedex',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const PokedexScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final prevScreenController = state.extra as AnimationController;
          if (animation.status == AnimationStatus.forward) {
            prevScreenController.forward();
          } else if (animation.status == AnimationStatus.reverse) {
            prevScreenController.reverse();
          }

          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) => DetailScreen(
        pokemon: state.extra as Pokemon,
      ),
    ),
    GoRoute(
      path: '/type',
      builder: (context, state) => TypeScreen(
        pokemonType: state.extra as PokemonType,
      ),
    ),
  ],
);

mixin Routes {
  static void openTypeScreen(BuildContext context, PokemonType type) {
    context.push('/type', extra: type);
  }

  static void openDetailScreen(BuildContext context, Pokemon pokemon) {
    context.push('/detail', extra: pokemon);
  }
}
