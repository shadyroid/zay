import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';

class HomeTopStoreItem extends StatelessWidget {
  const HomeTopStoreItem({
    super.key,
    required this.shop,
    required this.onTap,
  });

  final ShopBean shop;
  final VoidCallback onTap;

  static const double itemWidth = 88;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: itemWidth,
          child: Column(
            children: [
              Container(
                width: itemWidth,
                height: itemWidth,
                decoration: BoxDecoration(
                  color: AppColors.screenBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: _StoreLogo(url: shop.logoUrl ?? shop.iconUrl),
              ),
              const SizedBox(height: 8),
              Text(
                shop.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoreLogo extends StatelessWidget {
  const _StoreLogo({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return const SizedBox.shrink();
    }

    if (url!.contains('.svg')) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: SvgPicture.network(url!, fit: BoxFit.contain),
      );
    }

    return Image.network(
      url!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
