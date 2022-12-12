import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/datamodel/poke_stat.dart';
import 'package:pokemon/core/datamodel/pokemon.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/network_poke_image.dart';
import 'package:pokemon/core/utils/string_ext.dart';
import 'package:pokemon/interactor/get_pokemon_usecase.dart';
import 'package:pokemon/routes.dart';
import 'package:pokemon/screens/detail/short_detail_view.dart';
import 'package:pokemon/service/api/pokemon_api.dart';
import 'package:pokemon/service/local/pokemon_local.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../home/poke_app_bar.dart';
import '../home/poke_drawer.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isReady = false;
  bool hasError = false;

  late PokemonDetail _pokemonDetail;

  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      Future.microtask(() async {
        loadData();
      });
    });
  }

  Future loadData() async {
    final result = await GetPokemonUsecase(PokemonLocal(), PokemonApi())
        .start(widget.pokemon.id);

    if (result.isRight()) {
      setState(() {
        _pokemonDetail = result.asRight();
        isReady = true;
        hasError = false;
      });
      _refreshController.refreshCompleted();
    } else {
      setState(() {
        isReady = true;
        hasError = true;
      });
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PokeAppBar(),
      endDrawer: const PokeDrawer(),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: () => loadData(),
        enablePullDown: true,
        child: chooseBody(),
      ),
    );
  }

  Widget chooseBody() {
    if (!isReady) return const Center(child: CircularProgressIndicator());
    if (hasError) {
      return const Center(child: Text('Please Reload, Pull down screen'));
    } else {
      return showContent(context);
    }
  }

  Widget showContent(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
      children: [
        ShortDetailView(pokemon: widget.pokemon),
        const SizedBox(height: 32),
        ShortDetailView.sectionTitle(PokeText.otherImages),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 21,
          runSpacing: 10,
          children: _pokemonDetail.otherImages
              .map((e) => NetworkPokeImage(imageUrl: e, width: 100))
              .toList(),
        ),
        const SizedBox(height: 32),
        ShortDetailView.sectionTitle(PokeText.stat),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 21,
          runSpacing: 21,
          children: _pokemonDetail.pokeStats.map((e) => itemStat(e)).toList(),
        ),
        const SizedBox(height: 32),
        ShortDetailView.sectionTitle(PokeText.evolution),
        const SizedBox(height: 12),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 21,
          runSpacing: 21,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final evo in _pokemonDetail.evolutions.asMap().entries) ...[
              itemEvolution(context, evo.key, evo.value),
              if (evo.key != _pokemonDetail.evolutions.length - 1)
                const Icon(Icons.arrow_right_alt_rounded),
            ],
          ],
        ),
      ],
    );
  }

  Widget itemStat(PokeStat stat, {double size = 90}) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: stat.value / 100,
              strokeWidth: 6,
              color: stat.color,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    stat.value.toString(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: stat.color,
                    ),
                  ),
                  Text(
                    stat.name.toTitleCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 12, color: stat.color),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemEvolution(
    BuildContext context,
    int index,
    Pokemon pokemon, {
    double size = 100,
  }) {
    Color color = PokeColor.black;
    switch (index) {
      case 0:
        color = PokeColor.grass;
        break;
      case 1:
        color = PokeColor.yellow;
        break;
      case 2:
        color = PokeColor.water;
        break;
      case 3:
        color = PokeColor.fire;
        break;
    }
    return InkWell(
      child: Column(
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 6,
                    color: color,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: NetworkPokeImage(
                    imageUrl: pokemon.imageUrl,
                    width: 70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            pokemon.name.toTitleCase(),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
      onTap: () {
        Routes.openDetailScreen(context, pokemon);
      },
    );
  }
}
