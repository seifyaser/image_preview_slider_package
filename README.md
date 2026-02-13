# image_slider_preview

Image Slider Preview is a Flutter package that helps you display images in a smooth slider with page indicators and a full-screen image preview with zoom and pan support.

Creating a modern image preview experience in Flutter has never been easier 🚀

---

## Screenshots

<p align="center">
  <img src="https://iili.io/fZJ37CF.png" height="450"/>
  <img src="https://iili.io/fZJ3a4a.png" height="450"/>
  <img src="https://iili.io/fZJ3YEg.md.png" height="450"/>
</p>


---

## Demo

<p align="center">
  <img src="https://raw.githubusercontent.com/seifyaser/image_preview_slider_pakacge/main/screenshots/demo.gif" height="450"/>
</p>

---

## Features

- 📸 Image slider with page indicator  
- 🔄 Optional auto-play carousel  
- 🔍 Full screen image preview  
- 🤏 Pinch to zoom & pan  
- 🌐 Cached network images  
- 🎯 Simple and clean API  

---

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  image_slider_preview: ^0.0.8
```

---

## Usage

### Minimal — defaults only

```dart
ImageSliderWithIndicator(
  images: [
    'https://picsum.photos/400/300',
    'https://picsum.photos/401/300',
    'https://picsum.photos/402/300',
  ],
)
```

### Auto-play carousel

```dart
ImageSliderWithIndicator(
  images: [
    'https://picsum.photos/400/300',
    'https://picsum.photos/401/300',
    'https://picsum.photos/402/300',
  ],
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 3),          // optional, default 3s
  autoPlayAnimationDuration: Duration(milliseconds: 400), // optional, default 400ms
)
```

> Auto-play pauses while the user is dragging and resumes on release.

### Custom height & border radius

```dart
ImageSliderWithIndicator(
  images: [
    'https://picsum.photos/400/300',
    'https://picsum.photos/401/300',
    'https://picsum.photos/402/300',
  ],
  height: 300,        // optional, default 220
  borderRadius: 24,   // optional, default 12
)
```

---

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `images` | `List<String>` | **required** | List of image URLs |
| `height` | `double?` | `220` | Slider height |
| `borderRadius` | `double?` | `12` | Image corner radius |
| `autoPlay` | `bool` | `false` | Enable auto-carousel |
| `autoPlayInterval` | `Duration` | `3 seconds` | Delay between slides |
| `autoPlayAnimationDuration` | `Duration` | `400ms` | Slide transition speed |

---

## License

MIT — see [LICENSE](LICENSE) for details.
