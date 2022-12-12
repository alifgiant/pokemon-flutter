import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/datamodel/poke_type.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/images.dart';
import 'package:pokemon/core/res/strings.dart';
import 'package:pokemon/core/utils/string_ext.dart';
import 'package:pokemon/routes.dart';

class PokeDrawer extends StatelessWidget {
  const PokeDrawer({super.key, this.selectedMenu, this.extra});

  final String? selectedMenu;
  final dynamic extra;

  @override
  Widget build(BuildContext context) {
    final menus = _createMenus(context);
    return Drawer(
      child: ListView.builder(
        itemCount: menus.length,
        itemBuilder: (context, index) {
          final menu = menus[index];
          return menu.builder(context);
        },
      ),
    );
  }

  List<_Menus> _createMenus(BuildContext context) {
    return [
      _HeaderMenus(),
      _TextMenus(
        title: PokeText.home,
        current: selectedMenu,
        onTap: () => context.push('/'),
      ),
      _TextMenus(
        title: PokeText.typeMenu,
        current: selectedMenu,
      ),
      for (final type in PokemonType.all)
        _TextMenus(
          title: PokeText.typeItemMenu.replaceAll(
            '%s',
            type.name.toTitleCase(),
          ),
          current: selectedMenu,
          onTap: () => Routes.openTypeScreen(context, type),
        ),
    ];
  }
}

abstract class _Menus {
  const _Menus(this.builder);

  final Widget Function(BuildContext) builder;
}

class _HeaderMenus extends _Menus {
  _HeaderMenus()
      : super((ctx) => DrawerHeader(child: PokeImage.logo.toImage()));
}

class _TextMenus extends _Menus {
  _TextMenus({
    required String title,
    required String? current,
    void Function()? onTap,
  }) : super(
          (ctx) {
            final path = (current ?? '').toLowerCase();
            final isSelected = title.toLowerCase().contains(path);

            return ListTile(
              title: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w700 : null,
                  color: isSelected ? PokeColor.yellow : null,
                ),
              ),
              onTap: onTap,
            );
          },
        );
}
