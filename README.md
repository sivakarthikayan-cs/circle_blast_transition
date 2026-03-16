<div align="center">

<img src="https://raw.githubusercontent.com/sivakarthikayan-cs/circle_blast_transition/developer/example/assets/circle_blast_transition_radial_center.gif" width="160" alt="circle blast logo"/>

# circle_blast_transition

**A Flutter page transition that reveals screens through an animated grid of expanding circles.**  
Pure Flutter · Zero dependencies · Low-spec device friendly

[![pub version](https://img.shields.io/pub/v/circle_blast_transition.svg)](https://pub.dev/packages/circle_blast_transition)
[![pub points](https://img.shields.io/pub/points/circle_blast_transition)](https://pub.dev/packages/circle_blast_transition/score)
[![license](https://img.shields.io/github/license/sivakarthikayan-cs/circle_blast_transition)](LICENSE)
[![platform](https://img.shields.io/badge/platform-flutter-blue)](https://flutter.dev)

</div>

---

## ✨ Preview

<div align="center">

<table>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/sivakarthikayan-cs/circle_blast_transition/developer/example/assets/circle_blast_transition_radial_center.gif"
           width="180" alt="Radial Center" />
      <br/>
      <b>Radial Center</b>
      <br/>
      <sub>Circles explode from the centre outward</sub>
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/sivakarthikayan-cs/circle_blast_transition/developer/example/assets/circle_blast_transition_random.gif"
           width="180" alt="Random" />
      <br/>
      <b>Random</b>
      <br/>
      <sub>Circles pop in a scattered random order</sub>
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/sivakarthikayan-cs/circle_blast_transition/developer/example/assets/circle_blast_transition_diagonal.gif"
           width="180" alt="Diagonal" />
      <br/>
      <b>Diagonal</b>
      <br/>
      <sub>Wave sweeps top-left → bottom-right</sub>
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/sivakarthikayan-cs/circle_blast_transition/developer/example/assets/circle_blast_transition_top-bottom.gif"
           width="180" alt="Top to Bottom" />
      <br/>
      <b>Top → Bottom</b>
      <br/>
      <sub>Circles sweep row by row downward</sub>
    </td>
  </tr>
</table>

</div>

---

## 📦 Installation

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

## 🚀 Quick Start

```dart
import 'package:circle_blast_transition/circle_blast_transition.dart';

Navigator.push(
  context,
  CircleBlastRoute(
    page: const MyNextScreen(),
  ),
);
```

---

## 🎨 Blast Styles

| Style | Preview | Description |
|---|---|---|
| `BlastStyle.radialCenter` | 🔵 | Circles expand outward from the screen centre |
| `BlastStyle.random` | 🎲 | Circles appear in a stable random order |
| `BlastStyle.topToBottom` | ⬇️ | Sweeps row by row from top to bottom |
| `BlastStyle.diagonal` | ↘️ | Diagonal wave from top-left to bottom-right |

```dart
Navigator.push(
  context,
  CircleBlastRoute(
    page: const MyNextScreen(),
    style: BlastStyle.diagonal,       // pick your style
    cols: 9,                          // grid columns
    rows: 16,                         // grid rows
    duration: const Duration(milliseconds: 750),
  ),
);
```

---

## 🛠️ API Reference

### `CircleBlastRoute`

| Parameter | Type | Default | Description |
|---|---|---|---|
| `page` | `Widget` | **required** | Destination screen |
| `style` | `BlastStyle` | `radialCenter` | Circle reveal order |
| `cols` | `int` | `9` | Grid columns |
| `rows` | `int` | `16` | Grid rows |
| `duration` | `Duration` | `750ms` | Forward transition duration |
| `reverseDuration` | `Duration?` | same as `duration` | Reverse (pop) transition duration |
| `settings` | `RouteSettings?` | `null` | Passed to `PageRouteBuilder` |

### `CircleBlastTransition` (standalone widget)

Use this if you manage your own `AnimationController`:

```dart
CircleBlastTransition(
  animation: myController,   // Animation<double> 0 → 1
  style: BlastStyle.random,
  cols: 8,
  rows: 14,
  child: MyPage(),
)
```

---

## ⚡ Low-Spec Device Tips

This transition uses a `ClipPath` mask — the incoming page is rendered once and only the clip shape changes per frame. No snapshots, no extra layers.

| Setting | Recommendation |
|---|---|
| `cols` / `rows` | Use `6 × 10` on weak devices |
| `duration` | `500ms` reduces total frames rendered |
| Style | All 4 styles have identical GPU cost |

---

## 📁 Example App

A full interactive demo is included in the [`example/`](example/) folder.  
It lets you switch between all 4 styles and adjust the grid density live.

```sh
cd example
flutter run
```

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repo
2. Create your branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'Add my feature'`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a Pull Request

Please open an [issue](https://github.com/sivakarthikayan-cs/circle_blast_transition/issues) first for major changes.

---

## 📄 License

MIT © 2026 [Sivakarthikayan](https://github.com/sivakarthikayan-cs)

See the [LICENSE](LICENSE) file for details.

---

<div align="center">

If you find this package useful, please ⭐ the repo and 👍 it on [pub.dev](https://pub.dev/packages/circle_blast_transition)!

</div>
