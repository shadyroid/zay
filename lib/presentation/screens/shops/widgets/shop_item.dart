import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({
    super.key,
    required this.shop,
    required this.onTap,
  });

  final ShopBean shop;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final rating = shop.rating ?? '4.5';
    final tagline = shop.slogan ?? '';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ShopLogo(imageUrl: shop.logo, name: shop.name ?? ""),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shop.name ?? "",
                    style: Get.theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/ic_star.svg',
                        width: 14,
                        height: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style:
                            Get.theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${shop.reviewsCount ?? 0} ${'reviews'.tr})',
                        style:
                            Get.theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                      ),
                    ],
                  ),
                  if (tagline.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      tagline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopLogo extends StatelessWidget {
  const _ShopLogo({this.imageUrl, required this.name});

  final String? imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return AppImage.network(
        imageUrl!,
        width: 64,
        height: 64,
        fit: BoxFit.cover,
        shape: AppImageShape.rounded,
        borderRadius: 12,
        errorWidget: _ShopLogoPlaceholder(name: name),
      );
    }
    return SizedBox(
      width: 64,
      height: 64,
      child: _ShopLogoPlaceholder(name: name),
    );
  }
}

class _ShopLogoPlaceholder extends StatelessWidget {
  const _ShopLogoPlaceholder({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return ColoredBox(
      color: AppColors.screenBackground,
      child: Center(
        child: Text(
          initial,
          style: Get.theme.textTheme.titleLarge?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
