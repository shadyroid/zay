import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({
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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _ProductImage(imageUrl: product.image),
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
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Text(
                '\$${product.price}',
                style: Get.theme.textTheme.titleSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const Spacer(),
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
