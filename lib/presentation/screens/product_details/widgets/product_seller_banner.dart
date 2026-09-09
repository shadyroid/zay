import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class ProductSellerBanner extends StatelessWidget {
  const ProductSellerBanner({
    super.key,
    required this.shopName,
    required this.slogan,
    this.shopIconUrl,
    required this.onTap,
  });

  final String shopName;
  final String slogan;
  final String? shopIconUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (shopName.isEmpty) return const SizedBox.shrink();

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border),
            bottom: BorderSide(color: AppColors.border),
          ),
        ),
        child: Row(
          children: [
            _ShopAvatar(imageUrl: shopIconUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shopName,
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    slogan,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopAvatar extends StatelessWidget {
  const _ShopAvatar({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.screenBackground,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? AppImage.network(
              imageUrl!,
              width: 44,
              height: 44,
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
        width: 22,
        height: 22,
        colorFilter: const ColorFilter.mode(
          AppColors.textSecondary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
