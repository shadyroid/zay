import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';

class ProductSellerBanner extends StatelessWidget {
  const ProductSellerBanner({
    super.key,
    required this.shopName,
    required this.slogan,
    required this.onTap,
  });

  final String shopName;
  final String slogan;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (shopName.isEmpty) return const SizedBox.shrink();

    final initials = shopName.isNotEmpty
        ? shopName
              .split(' ')
              .where((w) => w.isNotEmpty)
              .take(2)
              .map((w) => w[0])
              .join()
              .toUpperCase()
        : '?';

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
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.screenBackground,
              child: Text(
                initials,
                style: Get.theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
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
