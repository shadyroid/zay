import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/order_bean.dart';
import 'package:hedma/presentation/screens/order_details/widgets/order_details_section_card.dart';

class OrderCustomerCard extends StatelessWidget {
  const OrderCustomerCard({super.key, required this.order});

  final OrderBean order;

  @override
  Widget build(BuildContext context) {
    return OrderDetailsSectionCard(
      title: 'customerData'.tr,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CustomerAvatar(imageUrl: order.customerImageUrl),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.customerName.isNotEmpty
                        ? order.customerName
                        : '—',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  if (order.customerAddress.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: SvgPicture.asset(
                            'assets/icons/ic_location.svg',
                            width: 16,
                            height: 16,
                            colorFilter: const ColorFilter.mode(
                              AppColors.textSecondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            order.customerAddress,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (order.customerPhone.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      '${'mobile'.tr} : ${order.customerPhone}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomerAvatar extends StatelessWidget {
  const _CustomerAvatar({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    return CircleAvatar(
      radius: 28,
      backgroundColor: AppColors.screenBackground,
      backgroundImage: url != null && url.isNotEmpty
          ? NetworkImage(url)
          : null,
      child: url == null || url.isEmpty
          ? SvgPicture.asset(
              'assets/icons/ic_person.svg',
              width: 28,
              height: 28,
              colorFilter: const ColorFilter.mode(
                AppColors.hint,
                BlendMode.srcIn,
              ),
            )
          : null,
    );
  }
}
