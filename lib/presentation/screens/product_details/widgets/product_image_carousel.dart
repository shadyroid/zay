import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class ProductImageCarousel extends StatelessWidget {
  const ProductImageCarousel({
    super.key,
    required this.images,
    required this.currentIndex,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onPageChanged,
  });

  final List<String> images;
  final int currentIndex;
  final RxBool isFavorite;
  final VoidCallback onFavoriteTap;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: images.isEmpty ? 1 : images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              if (images.isEmpty) return _placeholder();
              return AppImage.network(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                errorWidget: _placeholder(),
              );
            },
          ),
          PositionedDirectional(
            top: 12,
            end: 12,
            child: GestureDetector(
              onTap: onFavoriteTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Obx(
                    () => AnimatedScale(
                      scale: isFavorite.value ? 1.2 : 1.0,
                      duration: AppMotion.fast,
                      curve: Curves.easeOutBack,
                      child: SvgPicture.asset(
                        isFavorite.value
                            ? 'assets/icons/ic_heart_filled.svg'
                            : 'assets/icons/ic_favorite.svg',
                        width: 18,
                        height: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (images.length > 1)
            Positioned(
              left: 0,
              right: 0,
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (index) {
                  final active = index == currentIndex;
                  return AnimatedContainer(
                    duration: AppMotion.fast,
                    curve: AppMotion.standard,
                    width: active ? 18 : 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: active ? AppColors.primary : AppColors.border,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return ColoredBox(
      color: AppColors.screenBackground,
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/ic_product_placeholder.svg',
          width: 64,
          height: 64,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
