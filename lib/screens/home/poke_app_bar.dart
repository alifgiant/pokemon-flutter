import 'package:flutter/material.dart';
import 'package:pokemon/core/res/images.dart';

class PokeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PokeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: PokeImage.logo.toImage(),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
