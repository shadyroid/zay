import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/screens/images_viewer/controller.dart';

class ImagesViewerScreen extends GetView<ImagesViewerController> {
  const ImagesViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (controller.images.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            onPressed: Get.back,
            icon: SvgPicture.asset(
              'assets/icons/ic_close.svg',
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        body: const SizedBox.shrink(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: controller.images.length <= 1
            ? const SizedBox.shrink()
            : Obx(
                () => Text(
                  '${controller.pageIndex.value + 1} / ${controller.images.length}',
                  style: Get.theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: Get.back,
            icon: SvgPicture.asset(
              'assets/icons/ic_close.svg',
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: PhotoViewGallery.builder(
        onPageChanged: controller.onPageChanged,
        itemCount: controller.images.length,
        builder: (context, index) {
          final item = controller.images[index];
          return PhotoViewGalleryPageOptions(
            key: ValueKey('$index-$item'),
            controller: controller.photoControllers[index],
            minScale: PhotoViewComputedScale.contained * 0.5,
            maxScale: PhotoViewComputedScale.covered * 3,
            initialScale: PhotoViewComputedScale.contained,
            imageProvider: CachedNetworkImageProvider(item),
          );
        },
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        loadingBuilder: (_, _) => const Center(
          child: CupertinoActivityIndicator(color: Colors.white),
        ),
        pageController: controller.pageController,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Platform.isIOS ? 20 : 12,
            horizontal: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.images.length > 1) ...[
                _ControlButton(
                  onTap: controller.previousPage,
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              _IconControlButton(
                onTap: controller.zoomOut,
                icon: Icons.remove_rounded,
              ),
              const SizedBox(width: 12),
              _IconControlButton(
                onTap: controller.zoomIn,
                icon: Icons.add_rounded,
              ),
              if (controller.images.length > 1) ...[
                const SizedBox(width: 12),
                _ControlButton(
                  onTap: controller.nextPage,
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(padding: const EdgeInsets.all(9), child: child),
      ),
    );
  }
}

class _IconControlButton extends StatelessWidget {
  const _IconControlButton({required this.onTap, required this.icon});

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}
