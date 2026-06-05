import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/domain/models/beans/order_line_item_bean.dart';
import 'package:hedma/presentation/screens/order_details/widgets/order_details_section_card.dart';
import 'package:hedma/presentation/screens/orders/widgets/order_status_badge.dart';

class OrderItemsCard extends StatelessWidget {
  const OrderItemsCard({super.key, required this.order});

  final OrderBean order;

  @override
  Widget build(BuildContext context) {
    final items = order.items.isNotEmpty
        ? order.items
        : [
            OrderLineItemBean(
              id: order.id,
              productId: 0,
              productName: order.productName,
              productImageUrl: order.productImageUrl,
              size: order.size,
              quantity: order.quantity,
              unitPrice: order.total,
            ),
          ];

    return OrderDetailsSectionCard(
      title: '${'items'.tr} (${order.itemCount})',
      trailing: OrderStatusBadge(status: order.status),
      subtitle: '${'orderId'.tr} : ${order.id}',
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _OrderLineItemRow(item: items[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _OrderLineItemRow extends StatelessWidget {
  const _OrderLineItemRow({required this.item});

  final OrderLineItemBean item;

  @override
  Widget build(BuildContext context) {
    final sizeQty = item.size.isNotEmpty
        ? '${'size'.tr} : ${item.size} | ${'qty'.tr} : ${item.quantity}'
        : '${'qty'.tr} : ${item.quantity}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _ProductImage(imageUrl: item.productImageUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.productName.isNotEmpty
                    ? item.productName
                    : '${'product'.tr} #${item.productId}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Get.theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                sizeQty,
                style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              if (item.unitPrice.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  '\$${item.unitPrice}',
                  style: Get.theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary,
                      ),
                ),
              ],
            ],
          ),
        ),
      ],
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
        'assets/icons/ic_product_placeholder.svg',
        width: 36,
        height: 36,
      ),
    );
  }
}
