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
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ImageSliderWithIndicator(
            images: const [
              'https://picsum.photos/400/300',
              'https://picsum.photos/401/300',
              'https://picsum.photos/402/300',
            ],
            height: 220,       
            borderRadius: 12,  // border radius for image preview
          ),
        ),
      ),
    );
  }
}
