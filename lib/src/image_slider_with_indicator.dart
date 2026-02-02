import 'dart:developer';
import 'package:flutter/material.dart';
import 'cached_image_network.dart';
import 'image_preview.dart';

class ImageSliderWithIndicator extends StatefulWidget {
  final List<String> images;
  final double height;
  final double borderRadius;

  const ImageSliderWithIndicator({
    super.key,
    required this.images,
    this.height = 220,
    this.borderRadius = 12,
  });

  @override
  State<ImageSliderWithIndicator> createState() =>
      _ImageSliderWithIndicatorState();
}

class _ImageSliderWithIndicatorState
    extends State<ImageSliderWithIndicator> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _openImagePreview(BuildContext context, int startIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ImagePreviewPage(
          images: widget.images,
          initialIndex: startIndex,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Stack(
        children: [
          
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    log("Image tapped: $index");
                    _openImagePreview(context, index);
                  },
                  child: CachedImage(
                    imageUrl: widget.images[index],
                    borderRadius: widget.borderRadius,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

       
          if (widget.images.length > 1)
            Positioned(
  bottom: 16, 
  left: 0,
  right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentIndex == index ? 18 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
