import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon/core/res/colors.dart';
import 'package:pokemon/core/res/images.dart';
import 'package:pokemon/core/res/strings.dart';

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
    // TODO(alifakbar): dynamic menu
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
        onTap: () {},
      ),
      _TextMenus(
        title: PokeText.typeItemMenu,
        current: selectedMenu,
        onTap: () => context.push('/'),
      ),
      _TextMenus(
        title: PokeText.typeItemMenu,
        current: selectedMenu,
        onTap: () => context.push('/'),
      ),
      _TextMenus(
        title: PokeText.typeItemMenu,
        current: selectedMenu,
        onTap: () => context.push('/'),
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
    required void Function() onTap,
  }) : super(
          (ctx) => ListTile(
              title: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: title == current ? FontWeight.w700 : null,
                  color: title == current ? PokeColor.yellow : null,
                ),
              ),
              onTap: onTap),
        );
}
