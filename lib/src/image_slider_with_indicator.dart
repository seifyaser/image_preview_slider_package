import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'cached_image_network.dart';
import 'image_preview.dart';

class ImageSliderWithIndicator extends StatefulWidget {
  final List<String> images;
  final double? height;
  final double? borderRadius;

  /// Enable auto-play carousel.
  final bool autoPlay;

  /// Duration between each auto-advance.
  final Duration autoPlayInterval;

  /// Animation duration for the slide transition.
  final Duration autoPlayAnimationDuration;

  const ImageSliderWithIndicator({
    super.key,
    required this.images,
    this.height,
    this.borderRadius,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 400),
  });

  @override
  State<ImageSliderWithIndicator> createState() =>
      _ImageSliderWithIndicatorState();
}

class _ImageSliderWithIndicatorState
    extends State<ImageSliderWithIndicator> {
  int currentIndex = 0;
  final PageController _pageController = PageController();
  Timer? _autoPlayTimer;
  bool _isUserDragging = false;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  @override
  void didUpdateWidget(covariant ImageSliderWithIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoPlay != oldWidget.autoPlay ||
        widget.autoPlayInterval != oldWidget.autoPlayInterval) {
      _stopAutoPlay();
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  // ── Auto-play helpers ──────────────────────────────────────────────

  void _startAutoPlay() {
    if (!widget.autoPlay || widget.images.length <= 1) return;
    _autoPlayTimer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (_isUserDragging) return;
      final nextPage = (currentIndex + 1) % widget.images.length;
      _pageController.animateToPage(
        nextPage,
        duration: widget.autoPlayAnimationDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  // ── Navigation ─────────────────────────────────────────────────────

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

  // ── Build ──────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const SizedBox();
    }

    final effectiveHeight = widget.height ?? 220;
    final effectiveBorderRadius = widget.borderRadius ?? 12;

    return SizedBox(
      height: effectiveHeight,
      width: double.infinity,
      child: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollStartNotification &&
                  notification.dragDetails != null) {
                _isUserDragging = true;
              } else if (notification is ScrollEndNotification) {
                _isUserDragging = false;
              }
              return false;
            },
            child: PageView.builder(
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
                      borderRadius: effectiveBorderRadius,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
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
