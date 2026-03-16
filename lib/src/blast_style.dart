/// Controls the order in which the circles appear during the
/// [CircleBlastRoute] page transition.
enum BlastStyle {
  /// Circles expand outward from the centre of the screen.
  ///
  /// The centre circle reveals first; edge circles reveal last,
  /// giving a "explosion from the middle" feel.
  radialCenter,

  /// Circles appear in a stable pseudo-random order.
  ///
  /// Uses a fixed random seed so the pattern is consistent across
  /// every navigation but still looks scattered and organic.
  random,

  /// Circles sweep from the top of the screen to the bottom,
  /// row by row.
  topToBottom,

  /// Circles sweep diagonally from the top-left corner to the
  /// bottom-right corner.
  diagonal,
}
