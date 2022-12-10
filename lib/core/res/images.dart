import 'package:flutter/material.dart';

/// contains all image path for the app
mixin PokeImage {
  /// Welcome Screen
  static const logo = "assets/images/logo.webp";
  static const bulbasaur = "assets/images/bulbasaur.webp";
  static const charmender = "assets/images/charmender.webp";
  static const squirtle = "assets/images/squirtle.webp";
}

extension ExtPokeImage on String {
  Widget toImage({double? width, double? height}) {
    return Image.asset(this, width: width, height: height);
  }
}
