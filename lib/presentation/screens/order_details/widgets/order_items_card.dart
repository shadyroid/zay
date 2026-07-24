import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/order_bean.dart';
import 'package:zay/domain/models/beans/order_product_bean.dart';
import 'package:zay/presentation/screens/order_details/widgets/order_details_section_card.dart';
import 'package:zay/presentation/screens/orders/widgets/order_status_badge.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class OrderItemsCard extends StatelessWidget {
  const OrderItemsCard({super.key, required this.order});

  final OrderBean order;

  @override
  Widget build(BuildContext context) {

    return OrderDetailsSectionCard(
      title: '${'items'.tr} (${order.itemsCount})',
      trailing: OrderStatusBadge(status: order.status),
      subtitle: '${'orderId'.tr} : ${order.id}',
      child: Column(
        children: [
          for (var i = 0; i < (order.items?.length??0); i++) ...[
            if (i > 0) const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.all(16),
              child: _OrderLineItemRow(item: order.items![i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _OrderLineItemRow extends StatelessWidget {
  const _OrderLineItemRow({required this.item});

  final OrderProductBean item;

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: _ProductImage(imageUrl: item.productImage),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.productName??"",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Get.theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                '${'qty'.tr} : ${item.quantity}',
                style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              if (item.unitPrice!=null) ...[
                const SizedBox(height: 8),
                Text(
                  '£${item.unitPrice}',
                  style: Get.theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
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
      return AppImage.network(
        url,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorWidget: _placeholder(),
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
