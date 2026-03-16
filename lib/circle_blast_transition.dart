/// Circle Blast Transition
///
/// A Flutter page transition that reveals the incoming screen through
/// an animated grid of expanding circles — like a "blast" that assembles
/// the new page from small circles.
///
/// ## Quick start
///
/// ```dart
/// Navigator.push(
///   context,
///   CircleBlastRoute(
///     page: const MyNextScreen(),
///     style: BlastStyle.radialCenter,
///   ),
/// );
/// ```
library circle_blast_transition;

export 'src/blast_style.dart';
export 'src/circle_blast_route.dart';
export 'src/circle_blast_transition.dart';
