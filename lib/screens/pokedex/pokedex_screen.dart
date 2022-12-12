import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/bg_circle.dart';
import 'package:pokemon/interactor/get_pokemon_usecase.dart';
import 'package:pokemon/interactor/get_pokemons_usecase.dart';
import 'package:pokemon/routes.dart';
import 'package:pokemon/screens/pokedex/pokedex_item.dart';
import 'package:pokemon/screens/pokedex/pokedex_sheet.dart';
import 'package:pokemon/service/api/pokemon_api.dart';
import 'package:pokemon/service/local/pokemon_local.dart';

class PokedexScreen extends StatelessWidget {
  const PokedexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokeColor.lightYellow,
      body: Stack(
        children: [
          ...background(),
          backButton(context),
          _PokedexScreenForeground(),
        ],
      ),
    );
  }

  SafeArea backButton(BuildContext context) {
    return SafeArea(
      child: IconButton(
        icon: const BackButtonIcon(),
        onPressed: () => context.pop(),
      ),
    );
  }

  List<Widget> background() {
    return [
      const Align(
        alignment: Alignment(-1, -0.7),
        child: BgCircle(radius: 170),
      ),
      const Align(
        alignment: Alignment(1, 0.7),
        child: BgCircle(radius: 170),
      ),
    ];
  }
}

class _PokedexScreenForeground extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForegroundState();
}

class _ForegroundState extends State<_PokedexScreenForeground> {
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
    final result = await GetPokemonsUsecase(
      PokemonLocal(),
      PokemonApi(),
    ).start(offset: pageKey);

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
    return PagedListView<int, Pokemon>.separated(
      pagingController: _pagingController,
      padding: const EdgeInsets.all(26),
      builderDelegate: PagedChildBuilderDelegate<Pokemon>(
        itemBuilder: (ctx, pokemon, index) => PokedexItem(
          key: ObjectKey(pokemon),
          pokemon: pokemon,
          onCardTap: (pokemon) => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(42)),
            ),
            builder: (context) => PokedexSheet(pokemon: pokemon),
          ),
          onTypeTap: (type) => Routes.openTypeScreen(ctx, type),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 24),
    );
  }
}
