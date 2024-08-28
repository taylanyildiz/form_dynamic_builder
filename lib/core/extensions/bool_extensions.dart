extension BoolExtensions on bool {
  /// Value to int
  ///
  /// [true] -> 1
  /// [false] -> 0
  int toInt() {
    return this ? 1 : 0;
  }
}
