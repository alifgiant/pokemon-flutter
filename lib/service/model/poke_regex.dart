mixin PokeRegex {
  static final patternId = RegExp(r'.*\/([0-9]+)');
}

extension ExtPokeRegex on String {
  String getId() {
    return PokeRegex.patternId.firstMatch(this)?.group(1) ?? '0';
  }
}
