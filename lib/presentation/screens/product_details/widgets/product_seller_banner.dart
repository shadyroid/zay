import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';

class ProductSellerBanner extends StatelessWidget {
  const ProductSellerBanner({
    super.key,
    required this.shopName,
    required this.categories,
    required this.onTap,
  });

  final String shopName;
  final String categories;
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
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textPrimary,
                          ),
                      children: [
                        TextSpan(text: '${'soldBy'.tr} '),
                        TextSpan(
                          text: shopName,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  if (categories.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      categories,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ],
              ),
            ),
            SvgPicture.asset(
              AppIcons.chevronRight,
              width: 18,
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
