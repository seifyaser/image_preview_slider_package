import 'package:flutter/material.dart';
import 'cached_image_network.dart';

class ImagePreviewPage extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImagePreviewPage({
    super.key,
    required this.images,
    required this.initialIndex,
  });

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  late PageController _pageController;
  late int currentIndex;

  // للتحكم في الـ zoom والـ transformation
  final TransformationController _transformationController = TransformationController();

  static const double _minScale = 0.85;
  static const double _maxScale = 4.5;
  static const double _doubleTapQuickScale = 2.4;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

void _onDoubleTap() {
  final currentScale = _transformationController.value.getMaxScaleOnAxis();

  if (currentScale > 1.1) {
    // رجوع للوضع الطبيعي (zoom out)
    _transformationController.value = Matrix4.identity();
  } else {
    // زوم سريع مريح (zoom in)
    _transformationController.value = Matrix4.identity()
      ..scaleByDouble(
        _doubleTapQuickScale,  
        _doubleTapQuickScale,  
        1.0,                   
        1.0,                  
      );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: Stack(
          children: [
            // الصور نفسها
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                  // مهم: نرجّع الزوم للوضع الافتراضي عند تغيير الصورة
                  _transformationController.value = Matrix4.identity();
                });
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  transformationController: _transformationController,
                  minScale: _minScale,
                  maxScale: _maxScale,
                  boundaryMargin: const EdgeInsets.all(100),
                  clipBehavior: Clip.none,
                  panEnabled: true,
                  scaleEnabled: true,
                  child: GestureDetector(
                    // double tap → zoom in / out
                    onDoubleTap: _onDoubleTap,

                    // اختياري: double tap down لو حابب تحسب مكان اللمس بالظبط
                    // onDoubleTapDown: (details) { ... },

                    child: Center(
                      child: CachedImage(
                        imageUrl: widget.images[index],
                        fit: BoxFit.contain,
                        // لو عندك placeholder أو loading indicator حلو، ضيفه هنا
                      ),
                    ),
                  ),
                );
              },
            ),

            // مؤشر النقاط تحت (dots indicator)
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
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: currentIndex == index ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            currentIndex == index ? Colors.white : Colors.white54,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // اختياري: رقم الصورة الحالية (مثل 3/12)
            if (widget.images.length > 1)
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "${currentIndex + 1} / ${widget.images.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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