import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';

class FilterStoreChip extends StatelessWidget {
  const FilterStoreChip({
    super.key,
    required this.shop,
    required this.isSelected,
    required this.onTap,
  });

  final ShopBean shop;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        isSelected ? AppColors.secondary : Colors.transparent;

    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 10),
      child: Material(
        color: AppColors.screenBackground,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 14, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _ShopLogo(url: shop.logo ?? shop.icon),
                ),
                const SizedBox(width: 10),
                Text(
                  shop.name ?? "",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
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

class _ShopLogo extends StatelessWidget {
  const _ShopLogo({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return const SizedBox.shrink();
    }

    if (url!.contains('.svg')) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: SvgPicture.network(
          url!,
          fit: BoxFit.contain,
        ),
      );
    }

    return Image.network(
      url!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
