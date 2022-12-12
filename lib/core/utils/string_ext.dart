extension StringFormat on String {
  String toTitleCase() {
    if (isEmpty || length == 1) return this;
    return split(' ')
        .map((e) => e.substring(0, 1).toUpperCase() + e.substring(1))
        .join(' ');
  }
}
