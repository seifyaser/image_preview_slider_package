import 'package:flutter/material.dart';
import 'package:image_slider_preview/image_slider_preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Image Slider Preview Example'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            // ─────────────────────────────────────────────────────────
            // 1. Minimal usage — only [images] is required.
            //    Height defaults to 220 and borderRadius defaults to 12.
            // ─────────────────────────────────────────────────────────
            Text('1. Minimal usage (defaults)',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ImageSliderWithIndicator(
              images: [
                'https://picsum.photos/400/300',
                'https://picsum.photos/401/300',
                'https://picsum.photos/402/300',
              ],
            ),

            SizedBox(height: 32),

            // ─────────────────────────────────────────────────────────
            // 2. Auto-play carousel.
            //    Set [autoPlay] to true to auto-advance slides.
            //    Optionally customise:
            //      • autoPlayInterval          — delay between slides
            //                                    (default: 3 seconds)
            //      • autoPlayAnimationDuration  — slide transition speed
            //                                    (default: 400 ms)
            //    Auto-play pauses while the user is dragging and
            //    resumes automatically on release.
            // ─────────────────────────────────────────────────────────
            Text('2. Auto-play carousel',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ImageSliderWithIndicator(
              images: [
                'https://picsum.photos/400/300',
                'https://picsum.photos/401/300',
                'https://picsum.photos/402/300',
              ],
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 400),
            ),

            SizedBox(height: 32),

            // ─────────────────────────────────────────────────────────
            // 3. Custom height & borderRadius.
            //    Both are optional — pass them only when you need
            //    values different from the defaults (220 / 12).
            // ─────────────────────────────────────────────────────────
            Text('3. Custom height & border radius',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ImageSliderWithIndicator(
              images: [
                'https://picsum.photos/400/300',
                'https://picsum.photos/401/300',
                'https://picsum.photos/402/300',
              ],
              height: 300,
              borderRadius: 24,
              autoPlay: true,
            ),
          ],
        ),
      ),
    );
  }
}
