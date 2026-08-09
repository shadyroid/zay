import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:zay/presentation/base/base_controller.dart';

class ImagesViewerController extends BaseController {
  late PageController pageController;
  List<PhotoViewController> photoControllers = [];
  late int currentIndex;
  late List<String> images;

  final RxInt pageIndex = 0.obs;

  PhotoViewController get currentPhotoController =>
      photoControllers[currentIndex];

  double? get currentScale => photoControllers[currentIndex].scale;

  @override
  void onInit() {
    final args = Get.arguments;
    if (args is Map) {
      images = (args['images'] as List?)?.whereType<String>().toList() ?? [];
      currentIndex = (args['index'] as int?) ?? 0;
    } else {
      images = [];
      currentIndex = 0;
    }

    if (images.isEmpty) {
      images = [];
      currentIndex = 0;
    } else {
      currentIndex = currentIndex.clamp(0, images.length - 1);
    }

    pageIndex.value = currentIndex;
    pageController = PageController(initialPage: currentIndex);
    photoControllers = List.generate(
      images.length,
      (_) => PhotoViewController(),
    );
    super.onInit();
  }

  void onPageChanged(int index) {
    if (currentIndex >= 0 && currentIndex < photoControllers.length) {
      photoControllers[currentIndex].reset();
    }
    currentIndex = index;
    pageIndex.value = index;
  }

  void previousPage() {
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  void nextPage() {
    if (currentIndex < images.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  void zoomOut() {
    final scale = currentScale;
    if (scale == null) return;
    if (scale > 0.2) {
      currentPhotoController.scale = scale - 0.1;
    }
  }

  void zoomIn() {
    final scale = currentScale;
    if (scale == null) return;
    currentPhotoController.scale = scale + 0.1;
  }

  @override
  void onClose() {
    pageController.dispose();
    for (final photoController in photoControllers) {
      photoController.dispose();
    }
    super.onClose();
  }
}
