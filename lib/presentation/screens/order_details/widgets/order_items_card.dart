import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/presentation/screens/order_details/widgets/order_details_section_card.dart';
import 'package:hedma/presentation/screens/orders/widgets/order_status_badge.dart';

class OrderItemsCard extends StatelessWidget {
  const OrderItemsCard({super.key, required this.order});

  final OrderBean order;

  @override
  Widget build(BuildContext context) {
    final sizeQty = order.size.isNotEmpty
        ? '${'size'.tr} : ${order.size} | ${'qty'.tr} : ${order.quantity}'
        : '${'qty'.tr} : ${order.quantity}';

    return OrderDetailsSectionCard(
      title: '${'items'.tr} (${order.itemCount})',
      trailing: OrderStatusBadge(status: order.status),
      subtitle: '${'orderId'.tr} : ${order.id}',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _ProductImage(imageUrl: order.productImageUrl),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.productName.isNotEmpty
                        ? order.productName
                        : '${'order'.tr} #${order.id}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sizeQty,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${order.total}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondary,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({this.imageUrl});

  final String? imageUrl;

  static const double size = 88;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url != null && url.isNotEmpty) {
      return Image.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() {
    return Container(
      width: size,
      height: size,
      color: AppColors.screenBackground,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AppIcons.productPlaceholder,
        width: 36,
        height: 36,
      ),
    );
  }
}
