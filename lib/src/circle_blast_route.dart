import 'package:flutter/material.dart';

import 'blast_style.dart';
import 'circle_blast_transition.dart';

/// A [PageRouteBuilder] that reveals the new page through an animated
/// grid of expanding circles.
///
/// ### Basic usage
/// ```dart
/// Navigator.push(
///   context,
///   CircleBlastRoute(
///     page: const NextScreen(),
///   ),
/// );
/// ```
///
/// ### Custom style & grid density
/// ```dart
/// Navigator.push(
///   context,
///   CircleBlastRoute(
///     page: const NextScreen(),
///     style: BlastStyle.diagonal,
///     cols: 7,
///     rows: 12,
///     duration: const Duration(milliseconds: 600),
///   ),
/// );
/// ```
///
/// ### Low-spec devices
/// Reduce [cols] and [rows] (e.g. `cols: 5, rows: 9`) and shorten
/// [duration] to keep the animation smooth on weak hardware.
class CircleBlastRoute<T> extends PageRouteBuilder<T> {
  /// The destination page/screen to navigate to.
  final Widget page;

  /// Controls the order in which circles appear.
  ///
  /// Defaults to [BlastStyle.radialCenter].
  final BlastStyle style;

  /// Number of circle columns in the grid.
  ///
  /// Fewer columns = less GPU work = better on low-spec devices.
  /// Defaults to `9`.
  final int cols;

  /// Number of circle rows in the grid.
  ///
  /// Fewer rows = less GPU work = better on low-spec devices.
  /// Defaults to `16`.
  final int rows;

  /// Forward (push) animation duration. Defaults to 750 ms.
  final Duration duration;

  /// Reverse (pop) animation duration. Defaults to [duration].
  final Duration? reverseDuration;

  CircleBlastRoute({
    required this.page,
    this.style = BlastStyle.radialCenter,
    this.cols = 9,
    this.rows = 16,
    this.duration = const Duration(milliseconds: 750),
    this.reverseDuration,
    super.settings,
  }) : super(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: duration,
          reverseTransitionDuration:
              reverseDuration ?? duration,
          transitionsBuilder: (_, animation, __, child) {
            return CircleBlastTransition(
              animation: animation,
              cols: cols,
              rows: rows,
              style: style,
              child: child,
            );
          },
        );
}
