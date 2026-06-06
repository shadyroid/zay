import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onTap,
    this.isFavorite,
    this.onFavoriteTap,
  });

  final ProductBean product;
  final VoidCallback onTap;
  final RxBool? isFavorite;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    final rating = product.rating ?? '5.0';

    // 1. Safe Null Coalescing & Valuations
    final bool isOutOfStock = product.isOutOfStock ?? false;
    final double currentPrice = product.price ?? 0.0;
    final double originalPrice = product.originalPrice ?? 0.0;

    final bool hasDiscount = product.originalPrice != null &&
        product.price != null &&
        originalPrice > currentPrice;

    return InkWell(
      // Disable tap mechanics if item is out of stock
      onTap: isOutOfStock ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                // Product Image Container
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    // Apply a desaturated grayscale filter to the image if out of stock
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
                ),

                // 2. Out of Stock Semi-Transparent Overlay Banner
                if (isOutOfStock)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.75),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'outOfStock'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // 3. Discount Badge Overlay (Top Left/Start)
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

                // Favorite Button Overlay (Top Right/End)
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
                                () => SvgPicture.asset(
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
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.name ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Get.theme.textTheme.bodyMedium?.copyWith(
              color: isOutOfStock ? Colors.grey : AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),

          // 4. Redesigned Pricing & Rating Row
          Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4, // gap between active and original price
                  runSpacing: 2, // backup safety layout wrap
                  children: [
                    Text(
                      '£${currentPrice.toStringAsFixed(2)}',
                      style: Get.theme.textTheme.titleSmall?.copyWith(
                        color: isOutOfStock ? Colors.grey : AppColors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (hasDiscount && !isOutOfStock)
                      Text(
                        '£${originalPrice.toStringAsFixed(2)}',
                        style: Get.theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 11,
                        ),
                      ),
                  ],
                ),
              ),

              // Rating grouping pushed cleanly to the side
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/ic_star.svg',
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    rating,
                    style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
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
      return Image.network(
        imageUrl!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return SvgPicture.asset(
      'assets/icons/ic_product_placeholder.svg',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
