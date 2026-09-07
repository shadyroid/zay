import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/domain/models/beans/product_bean.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onTap,
    this.isFavorite,
    this.onFavoriteTap,
    this.animationIndex,
  });

  final ProductBean product;
  final VoidCallback onTap;
  final RxBool? isFavorite;
  final VoidCallback? onFavoriteTap;

  /// When set, plays a staggered entrance animation.
  final int? animationIndex;

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = product.isOutOfStock ?? false;
    final double currentPrice = product.price ?? 0.0;
    final double originalPrice = product.originalPrice ?? 0.0;
    final bool hasDiscount = product.originalPrice != null &&
        product.price != null &&
        originalPrice > currentPrice;
    final shopIconUrl = product.shop?.logo ?? product.shop?.icon;

    final image = Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: isOutOfStock
              ? ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.saturation,
                  ),
                  child: _ProductImage(imageUrl: product.image),
                )
              : _ProductImage(imageUrl: product.image),
        ),
        if (isOutOfStock)
          ColoredBox(
            color: Colors.black.withValues(alpha: 0.35),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'outOfStock'.tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        if (hasDiscount && !isOutOfStock)
          PositionedDirectional(
            top: 8,
            start: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${(((originalPrice - currentPrice) / originalPrice) * 100).toStringAsFixed(0)}% OFF',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (onFavoriteTap != null && isFavorite != null)
          PositionedDirectional(
            top: 8,
            end: 8,
            child: GestureDetector(
              onTap: onFavoriteTap,
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Obx(
                    () => AnimatedScale(
                      scale: isFavorite!.value ? 1.15 : 1.0,
                      duration: AppMotion.fast,
                      curve: Curves.easeOutBack,
                      child: SvgPicture.asset(
                        isFavorite!.value
                            ? 'assets/icons/ic_heart_filled.svg'
                            : 'assets/icons/ic_favorite.svg',
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );

    Widget content = AnimatedPress(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final useExpanded = constraints.hasBoundedHeight &&
              constraints.maxHeight.isFinite;

          return Column(
            mainAxisSize: useExpanded ? MainAxisSize.max : MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (useExpanded)
                Expanded(child: image)
              else
                AspectRatio(aspectRatio: 0.78, child: image),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.theme.textTheme.bodyMedium?.copyWith(
                        color: isOutOfStock
                            ? Colors.grey
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  _ShopIcon(imageUrl: shopIconUrl),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    '£${currentPrice.toStringAsFixed(2)}',
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: isOutOfStock ? Colors.grey : AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (hasDiscount) ...[
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        '£${originalPrice.toStringAsFixed(2)}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

            ],
          );
        },
      ),
    );

    if (animationIndex != null) {
      content = content.animateStagger(animationIndex!);
    }

    return content;
  }
}

class _ShopIcon extends StatelessWidget {
  const _ShopIcon({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: AppColors.screenBackground,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? AppImage.network(
              imageUrl!,
              width: 20,
              height: 20,
              fit: BoxFit.cover,
              shape: AppImageShape.circle,
              errorWidget: _placeholder(),
            )
          : _placeholder(),
    );
  }

  Widget _placeholder() {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/ic_nav_shops.svg',
        width: 12,
        height: 12,
        colorFilter: const ColorFilter.mode(
          AppColors.textSecondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return AppImage.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorWidget: _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return ColoredBox(
      color: AppColors.screenBackground,
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/ic_product_placeholder.svg',
          width: 48,
          height: 48,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
