import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/presentation/screens/orders/widgets/order_status_badge.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.order,
    required this.onTap,
  });

  final OrderBean order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final sizeQty = order.size.isNotEmpty
        ? '${'size'.tr} : ${order.size} | ${'qty'.tr} : ${order.quantity}'
        : '${'qty'.tr} : ${order.quantity}';

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${'orderId'.tr} : ${order.id}',
                        style: Get.theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ),
                    OrderStatusBadge(status: order.status),
                  ],
                ),
              ),
              const Divider(height: 1, thickness: 1, color: AppColors.border),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _OrderProductImage(
                        imageUrl: order.productImageUrl,
                      ),
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
                            style: Get.theme
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            sizeQty,
                            style: Get.theme
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            order.date,
                            style: Get.theme
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${order.total}',
                            style: Get.theme
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderProductImage extends StatelessWidget {
  const _OrderProductImage({this.imageUrl});

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
