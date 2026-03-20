import 'dart:math';

import 'package:flutter/material.dart';

import 'blast_style.dart';

/// Wraps [child] in a circle-blast reveal animation driven by [animation].
///
/// You can use this widget directly if you need to compose the transition
/// yourself (e.g. inside a custom [PageRoute] or a Hero widget).
///
/// ```dart
/// CircleBlastTransition(
///   animation: myController,
///   style: BlastStyle.random,
///   cols: 8,
///   rows: 14,
///   child: MyPage(),
/// )
/// ```
class CircleBlastTransition extends StatelessWidget {
  /// The 0 → 1 animation that drives the reveal.
  final Animation<double> animation;

  /// The widget (page) being revealed.
  final Widget child;

  /// Number of circle columns. See [CircleBlastRoute.cols].
  final int cols;

  /// Number of circle rows. See [CircleBlastRoute.rows].
  final int rows;

  /// Order in which circles appear. See [BlastStyle].
  final BlastStyle style;

  const CircleBlastTransition({
    super.key,
    required this.animation,
    required this.child,
    this.cols = 9,
    this.rows = 16,
    this.style = BlastStyle.radialCenter,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        final smoothed = Curves.easeInOut.transform(animation.value);
        return ClipPath(
          clipper: _CircleBlastClipper(
            progress: smoothed,
            cols: cols,
            rows: rows,
            style: style,
          ),
          child: child,
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
//  Internal Clipper
// ─────────────────────────────────────────────

class _CircleBlastClipper extends CustomClipper<Path> {
  final double progress;
  final int cols;
  final int rows;
  final BlastStyle style;

  /// Stable per-grid random stagger values, keyed by "colsxrows".
  static final Map<String, List<double>> _randomCache = {};

  const _CircleBlastClipper({
    required this.progress,
    required this.cols,
    required this.rows,
    required this.style,
  });

  // ── Stagger helpers ──────────────────────────────────────────────────

  List<double> _getRandomStagger() {
    final key = '${cols}x$rows';
    if (!_randomCache.containsKey(key)) {
      final rng = Random(42); // fixed seed → stable, repeatable pattern
      final total = cols * rows;
      final order = List.generate(total, (i) => i)..shuffle(rng);
      final result = List<double>.filled(total, 0);
      for (int i = 0; i < total; i++) {
        result[order[i]] = i / total;
      }
      _randomCache[key] = result;
    }
    return _randomCache[key]!;
  }

  /// Returns a 0–[_kMaxStagger] stagger offset for cell (row, col).
  ///
  /// The stagger is a fraction of the total animation timeline.
  /// [_kMaxStagger] must be < 1.0 so that [_kAvailable] > 0.
  static const double _kMaxStagger = 0.55;
  static const double _kAvailable = 1.0 - _kMaxStagger;

  double _stagger(int row, int col) {
    switch (style) {
      case BlastStyle.radialCenter:
        final cx = (cols - 1) / 2.0;
        final cy = (rows - 1) / 2.0;
        final maxDist = sqrt(cx * cx + cy * cy);
        if (maxDist == 0) return 0;
        final dist = sqrt(pow(col - cx, 2) + pow(row - cy, 2));
        return (dist / maxDist) * _kMaxStagger;

      case BlastStyle.random:
        return _getRandomStagger()[row * cols + col] * _kMaxStagger;

      case BlastStyle.topToBottom:
        if (rows <= 1) return 0;
        return (row / (rows - 1)) * _kMaxStagger;

      case BlastStyle.diagonal:
        final maxSum = (cols - 1) + (rows - 1);
        if (maxSum == 0) return 0;
        return ((col + row) / maxSum) * _kMaxStagger;

      case BlastStyle.leftToRight:
        if (cols <= 1) return 0;
        return (col / (cols - 1)) * _kMaxStagger;
    }
  }

  // ── Pop curve ────────────────────────────────────────────────────────

  /// Adds a subtle overshoot so each circle "pops" into place.
  ///
  /// Grows to 112 % of max radius then settles back to 100 %.
  static double _popCurve(double t) {
    if (t < 0.8) {
      return Curves.easeOut.transform(t / 0.8) * 1.12;
    }
    return 1.12 - 0.12 * ((t - 0.8) / 0.2);
  }

  // ── Clip path ────────────────────────────────────────────────────────

  @override
  Path getClip(Size size) {
    final path = Path();
    final cellW = size.width / cols;
    final cellH = size.height / rows;

    // Radius large enough to fully cover each rectangular cell.
    final maxRadius = sqrt(cellW * cellW + cellH * cellH) / 2;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final stagger = _stagger(row, col);
        final local = ((progress - stagger) / _kAvailable).clamp(0.0, 1.0);
        if (local <= 0) continue;

        final radius = maxRadius * _popCurve(local);
        final cx = cellW * col + cellW / 2;
        final cy = cellH * row + cellH / 2;

        path.addOval(
          Rect.fromCircle(center: Offset(cx, cy), radius: radius),
        );
      }
    }

    return path;
  }

  @override
  bool shouldReclip(_CircleBlastClipper old) =>
      old.progress != progress ||
      old.cols != cols ||
      old.rows != rows ||
      old.style != style;
}
