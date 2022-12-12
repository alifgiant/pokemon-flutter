import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/network_poke_image.dart';
import 'package:pokemon/core/utils/string_ext.dart';
import 'package:pokemon/interactor/get_pokemons_by_type_usecase.dart';
import 'package:pokemon/routes.dart';
import 'package:pokemon/screens/pokedex/pokedex_sheet.dart';
import 'package:provider/provider.dart';

import '../core/utils/bg_circle.dart';
import 'home/poke_app_bar.dart';
import 'home/poke_drawer.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({super.key, required this.pokemonType});

  final PokemonType pokemonType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokeAppBar(),
      endDrawer: const PokeDrawer(),
      body: Stack(
        children: [
          ...background(),
          foreground(),
        ],
      ),
    );
  }

  List<Widget> background() {
    return [
      Align(
        alignment: const Alignment(-1, -0.7),
        child: BgCircle(
          radius: 170,
          color: pokemonType.color,
        ),
      ),
      Align(
        alignment: const Alignment(1, 0.7),
        child: BgCircle(
          radius: 170,
          color: pokemonType.color,
        ),
      ),
    ];
  }

  Column foreground() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            PokeText.typeScreenTitle
                .replaceAll('%s', pokemonType.name)
                .toTitleCase(),
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(child: _TypeScreenContent(pokemonType)),
      ],
    );
  }
}

class _TypeScreenContent extends StatefulWidget {
  final PokemonType pokemonType;

  const _TypeScreenContent(this.pokemonType);

  @override
  State<StatefulWidget> createState() => _TypeScreenContentState();
}

class _TypeScreenContentState extends State<_TypeScreenContent> {
  final PagingController<int, Pokemon> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    final result = await GetPokemonByTypeUsecase(
      context.read(),
      context.read(),
    ).start(
      offset: pageKey,
      typeiId: widget.pokemonType.id,
    );

    if (result.isRight()) {
      final pokemons = result.asRight();
      if (pokemons.isEmpty) {
        _pagingController.appendLastPage([]);
      } else {
        _pagingController.appendPage(pokemons, pageKey + pokemons.length);
      }
    } else if (result.isLeft()) {
      _pagingController.error = result.asLeft();
    } else {
      _pagingController.error = StateError('Please Refresh');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Pokemon>(
      padding: const EdgeInsets.all(24),
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Pokemon>(
        itemBuilder: (ctx, pokemon, index) {
          final isFirst = index == 0;

          return ClipRRect(
            borderRadius: isFirst
                ? const BorderRadius.vertical(top: Radius.circular(24))
                : BorderRadius.zero,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 7,
                sigmaY: 7,
              ),
              child: GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 21,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NetworkPokeImage(imageUrl: pokemon.imageUrl, width: 75),
                      const SizedBox(width: 10),
                      Container(
                        color: PokeColor.lightGrey,
                        height: 94,
                        width: 1,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: pokeInfo(
                          pokemon.id.toPokeId(),
                          pokemon,
                          context,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(42)),
                  ),
                  builder: (context) => PokedexSheet(pokemon: pokemon),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget pokeInfo(String txtId, Pokemon pokemon, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '#$txtId',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: PokeColor.lightGrey,
          ),
        ),
        Text(
          pokemon.name.toTitleCase(),
          style: GoogleFonts.poppins(
            fontSize: 16,
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
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  onPressed: () => Routes.openTypeScreen(context, e),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
