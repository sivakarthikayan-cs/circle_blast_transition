import 'package:circle_blast_transition/circle_blast_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ── BlastStyle enum ──────────────────────────────────────────────────

  group('BlastStyle', () {
    test('has four values', () {
      expect(BlastStyle.values.length, 4);
    });
  });

  // ── CircleBlastRoute ────────────────────────────────────────────────

  group('CircleBlastRoute', () {
    testWidgets('builds without error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) => TextButton(
              onPressed: () => Navigator.push(
                ctx,
                CircleBlastRoute(
                  page: const Scaffold(body: Text('Next')),
                ),
              ),
              child: const Text('Go'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      // The new page should be (partially) visible during animation.
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('completes forward transition', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) => TextButton(
              onPressed: () => Navigator.push(
                ctx,
                CircleBlastRoute(
                  page: const Scaffold(body: Text('Arrived')),
                  duration: const Duration(milliseconds: 200),
                ),
              ),
              child: const Text('Go'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();
      expect(find.text('Arrived'), findsOneWidget);
    });

    for (final style in BlastStyle.values) {
      testWidgets('works with style=$style', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (ctx) => TextButton(
                onPressed: () => Navigator.push(
                  ctx,
                  CircleBlastRoute(
                    page: Scaffold(body: Text('Style: $style')),
                    style: style,
                    cols: 4,
                    rows: 6,
                    duration: const Duration(milliseconds: 100),
                  ),
                ),
                child: const Text('Go'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Go'));
        await tester.pumpAndSettle();
        expect(find.text('Style: $style'), findsOneWidget);
      });
    }
  });

  // ── CircleBlastTransition ───────────────────────────────────────────

  group('CircleBlastTransition', () {
    testWidgets('renders child at progress=1', (tester) async {
      final controller = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(milliseconds: 300),
      );
      controller.value = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: CircleBlastTransition(
            animation: controller,
            child: const Scaffold(body: Text('Done')),
          ),
        ),
      );

      expect(find.text('Done'), findsOneWidget);
      controller.dispose();
    });
  });
}
