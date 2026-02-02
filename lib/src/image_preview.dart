import 'package:flutter/material.dart';
import 'cached_image_network.dart';


class ImagePreviewPage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImagePreviewPage({super.key, 
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  late PageController _controller;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

   
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

 body: SafeArea(
  child: Stack(
    children: [
      /// ===== Images =====
      Center(
        child: PageView.builder(
          controller: _controller,
          itemCount: widget.images.length,
          onPageChanged: (index) {
            setState(() => currentIndex = index);
          },
          itemBuilder: (context, index) {
            return InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              panEnabled: true,
              child: Center(
                child: CachedImage(
                  imageUrl: widget.images[index],
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),

      /// ===== Bottom Indicator =====
      if (widget.images.length > 1)
        Positioned(
          bottom: 20,
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
                      : Colors.white54,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
    ],
  ),
),

    );
  }
}
