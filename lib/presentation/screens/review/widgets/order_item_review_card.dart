import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/enums/review_size_fit.dart';
import 'package:zay/presentation/screens/review/models/order_item_review_draft.dart';
import 'package:zay/presentation/screens/review/widgets/product_rating_section.dart';
import 'package:zay/presentation/screens/review/widgets/review_note_field.dart';
import 'package:zay/presentation/screens/review/widgets/size_evaluation_section.dart';
import 'package:zay/presentation/widgets/app_image.dart';

class OrderItemReviewCard extends StatelessWidget {
  const OrderItemReviewCard({
    super.key,
    required this.draft,
    required this.index,
    required this.total,
    required this.onSizeFitSelected,
    required this.onRatingSelected,
  });

  final OrderItemReviewDraft draft;
  final int index;
  final int total;
  final ValueChanged<ReviewSizeFit> onSizeFitSelected;
  final ValueChanged<int> onRatingSelected;

  @override
  Widget build(BuildContext context) {
    final item = draft.item;

    return Container(
      margin: EdgeInsets.only(bottom: index < total - 1 ? 16 : 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (total > 1) ...[
            Text(
              '${'item'.tr} ${index + 1} / $total',
              style: Get.theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
          ],
          Row(
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
          ),
          const SizedBox(height: 24),
          Obx(
            () => SizeEvaluationSection(
              selected: draft.selectedSizeFit.value,
              onSelected: onSizeFitSelected,
            ),
          ),
          const SizedBox(height: 24),
          Obx(
            () => ProductRatingSection(
              rating: draft.selectedRating.value,
              onRatingSelected: onRatingSelected,
            ),
          ),
          const SizedBox(height: 24),
          ReviewNoteField(controller: draft.commentController),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({this.imageUrl});

  final String? imageUrl;

  static const double size = 72;

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
        width: 32,
        height: 32,
      ),
    );
  }
}
