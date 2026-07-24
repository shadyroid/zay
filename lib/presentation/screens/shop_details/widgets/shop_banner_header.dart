import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zay/domain/models/beans/shop_bean.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class ShopBannerHeader extends StatelessWidget {
  const ShopBannerHeader({super.key, required this.shop});

  final ShopBean shop;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 200,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: shop.banner != null
                ? AppImage.network(
                    shop.banner!,
                    fit: BoxFit.cover,
                    errorWidget: const ColoredBox(color: Color(0xFFE8E8E8)),
                  )
                : const ColoredBox(color: Color(0xFFE8E8E8)),
          ),
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE8E8E8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: shop.logo != null
                  ? AppImage.network(
                      shop.logo!,
                      fit: BoxFit.cover,
                      errorWidget: _logoPlaceholder(),
                    )
                  : _logoPlaceholder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoPlaceholder() {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/ic_product_placeholder.svg',
        width: 48,
        height: 48,
      ),
    );
  }
}
