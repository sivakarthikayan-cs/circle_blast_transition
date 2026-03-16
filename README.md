# circle_blast_transition

A Flutter page transition that reveals the incoming screen through an animated
grid of expanding circles — like a "blast" that assembles the new page from
small dots. Pure Flutter, zero dependencies, optimised for low-spec devices.

---

## Preview

```
[ Home Screen ]  ──navigate──►  small circles pop in  ──►  [ Next Screen ]
```

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  circle_blast_transition: ^0.1.0
```

Then run:

```sh
flutter pub get
```

---

## Usage

### Minimal

```dart
import 'package:circle_blast_transition/circle_blast_transition.dart';

Navigator.push(
  context,
  CircleBlastRoute(page: const MyNextScreen()),
);
```

### All options

```dart
Navigator.push(
  context,
  CircleBlastRoute(
    page: const MyNextScreen(),

    // How the circles appear (default: radialCenter)
    style: BlastStyle.diagonal,

    // Grid density — lower = better on weak devices (defaults: 9 × 16)
    cols: 7,
    rows: 12,

    // Animation duration (default: 750 ms)
    duration: const Duration(milliseconds: 600),

    // Pop duration (defaults to duration)
    reverseDuration: const Duration(milliseconds: 400),
  ),
);
```

### Using CircleBlastTransition directly

If you manage your own route or controller, use the widget directly:

```dart
CircleBlastTransition(
  animation: myAnimationController,   // 0 → 1
  style: BlastStyle.random,
  cols: 8,
  rows: 14,
  child: MyPage(),
)
```

---

## Blast styles

| Value | Effect |
|---|---|
| `BlastStyle.radialCenter` | Circles explode outward from the screen centre |
| `BlastStyle.random` | Circles appear in a stable random order |
| `BlastStyle.topToBottom` | Sweeps row-by-row from top to bottom |
| `BlastStyle.diagonal` | Diagonal wave from top-left to bottom-right |

---

## Performance tips for low-spec devices

| Setting | Recommendation |
|---|---|
| `cols` / `rows` | Start with `6 × 10`; increase only if the device handles it |
| `duration` | `500 ms` is visually smooth and leaves less GPU time per frame |
| Curve | Internally uses `Curves.easeInOut` + a pop curve — no extra config needed |

The transition uses a **`ClipPath`** mask — the new page is rendered once and
the clip shape changes every frame. This avoids snapshot layers and is the
cheapest GPU approach for this kind of reveal.

---

## API reference

### `CircleBlastRoute<T>`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `page` | `Widget` | — | Destination screen (required) |
| `style` | `BlastStyle` | `radialCenter` | Circle reveal order |
| `cols` | `int` | `9` | Grid columns |
| `rows` | `int` | `16` | Grid rows |
| `duration` | `Duration` | `750 ms` | Forward animation duration |
| `reverseDuration` | `Duration?` | same as `duration` | Reverse animation duration |
| `settings` | `RouteSettings?` | `null` | Passed to `PageRouteBuilder` |

### `CircleBlastTransition`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `animation` | `Animation<double>` | — | 0→1 driver (required) |
| `child` | `Widget` | — | Page being revealed (required) |
| `style` | `BlastStyle` | `radialCenter` | Circle reveal order |
| `cols` | `int` | `9` | Grid columns |
| `rows` | `int` | `16` | Grid rows |

---

## License

MIT © 2026
