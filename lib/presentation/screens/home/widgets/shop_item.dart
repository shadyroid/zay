import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

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

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: Material(
        color: AppColors.screenBackground,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ShopIcon(
                  iconUrl: shop.logoUrl ?? shop.iconUrl ?? "",
                  color: AppColors.textPrimary,
                ),
                const SizedBox(width: 8),
                Text(
                  shop.name ?? "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight:
                           FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShopIcon extends StatelessWidget {
  const _ShopIcon({required this.iconUrl, required this.color});

  final String iconUrl;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (iconUrl.isEmpty) {
      return SvgPicture.asset(
        'assets/icons/ic_category_all.svg',
        width: 18,
        height: 18,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }

    if (iconUrl.startsWith('assets/')) {
      return SvgPicture.asset(
        iconUrl,
        width: 18,
        height: 18,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }

    if (!iconUrl.startsWith('http')) {
      return Text(iconUrl, style: const TextStyle(fontSize: 16));
    }

    return SvgPicture.network(
      iconUrl,
      width: 18,
      height: 18,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      placeholderBuilder: (context) => SizedBox(
        width: 18,
        height: 18,
        child: AppProgressIndicator(radius: 8, color: color),
      ),
      errorBuilder: (context, error, stackTrace) => SvgPicture.asset(
        'assets/icons/ic_category_all.svg',
        width: 18,
        height: 18,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
