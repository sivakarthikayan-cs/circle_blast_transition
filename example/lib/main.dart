import 'package:circle_blast_transition/circle_blast_transition.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circle Blast Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

// ─── Home Screen ────────────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BlastStyle _selected = BlastStyle.radialCenter;
  int _cols = 9;
  int _rows = 16;
  int _duration = 400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Circle Blast Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Style picker ──────────────────────────────────────────
              const Text(
                'Blast style',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: BlastStyle.values.map((s) {
                  return ChoiceChip(
                    label: Text(_styleLabel(s)),
                    selected: _selected == s,
                    onSelected: (_) => setState(() => _selected = s),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // ── Grid density ─────────────────────────────────────────
              const Text(
                'Grid density  (lower = better on weak devices)',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Cols: ', style: TextStyle(color: Colors.white)),
                  Expanded(
                    child: Slider(
                      value: _cols.toDouble(),
                      min: 1,
                      max: 15,
                      divisions: 12,
                      label: '$_cols',
                      onChanged: (v) => setState(() => _cols = v.round()),
                    ),
                  ),
                  Text('$_cols', style: const TextStyle(color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  const Text('Rows: ', style: TextStyle(color: Colors.white)),
                  Expanded(
                    child: Slider(
                      value: _rows.toDouble(),
                      min: 1,
                      max: 22,
                      divisions: 18,
                      label: '$_rows',
                      onChanged: (v) => setState(() => _rows = v.round()),
                    ),
                  ),
                  Text('$_rows', style: const TextStyle(color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  const Text('Duration (ms): ',
                      style: TextStyle(color: Colors.white)),
                  Expanded(
                    child: Slider(
                      value: _duration.toDouble(),
                      min: 400,
                      max: 1000,
                      divisions: 18,
                      label: '$_duration',
                      onChanged: (v) => setState(() => _duration = v.round()),
                    ),
                  ),
                  Text('$_duration',
                      style: const TextStyle(color: Colors.white)),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      // ── Navigate button ───────────────────────────────────────
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: SizedBox(
          height: 50,
          child: Center(
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  CircleBlastRoute(
                    page: const DetailScreen(),
                    style: _selected,
                    cols: _cols,
                    rows: _rows,
                    duration: Duration(milliseconds: _duration),
                  ),
                );
              },
              label: const Text('🚀 Launch transition',
                  style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ),
    );
  }

  String _styleLabel(BlastStyle s) => switch (s) {
        BlastStyle.radialCenter => '🔵 Radial',
        BlastStyle.random => '🎲 Random',
        BlastStyle.topToBottom => '⬇️ Top→Bottom',
        BlastStyle.diagonal => '↘️ Diagonal',
      };
}

// ─── Detail Screen ───────────────────────────────────────────────────────────

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F3460),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Detail Screen'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('✨', style: TextStyle(fontSize: 64)),
            SizedBox(height: 16),
            Text(
              'Assembled from circles!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Press back to see the reverse transition.',
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
