import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';

class HomeProductItem extends StatelessWidget {
  const HomeProductItem({
    super.key,
    required this.product,
    required this.shopName,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  final ProductBean product;
  final String shopName;
  final RxBool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  static const double cardWidth = 150;

  /// Height for horizontal [ListView] rows that host this item.
  static double get listHeight {
    const imageHeight = cardWidth / 0.78;
    const detailsHeight = 8 + 20 + 4 + 18 + 6 + 22;
    return imageHeight + detailsHeight;
  }

  @override
  Widget build(BuildContext context) {
    final rating = product.rating ?? '5.0';

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12),
      child: SizedBox(
        width: cardWidth,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 0.78,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _ProductImage(imageUrl: product.image),
                      ),
                    ),
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
                              isFavorite.value
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
              const SizedBox(height: 8),
              Text(
                product.name ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (shopName.isNotEmpty) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ic_check.svg',
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        AppColors.selectedCheck,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        shopName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    '\$${product.price}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ],
          ),
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
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return SvgPicture.asset(
      'assets/icons/ic_product_placeholder.svg',
      fit: BoxFit.cover,
    );
  }
}
