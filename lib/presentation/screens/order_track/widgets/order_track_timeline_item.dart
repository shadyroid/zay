import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_date_format.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/domain/models/beans/order_track_step_bean.dart';
import 'package:zay/domain/models/enums/order_track_step_icon.dart';

class OrderTrackTimelineItem extends StatelessWidget {
  const OrderTrackTimelineItem({
    super.key,
    required this.step,
    required this.isLast,
    required this.connectorIsActive,
  });

  final OrderTrackStepBean step;
  final bool isLast;
  final bool connectorIsActive;

  @override
  Widget build(BuildContext context) {
    final connectorColor =
        connectorIsActive ? AppColors.orderSuccess : AppColors.border;
    final subtitle = step.trimmedNote ?? step.descriptionKey?.tr ?? '';
    final changedBy = step.trimmedChangedBy;
    final timestamp = AppDateFormat.friendly(step.createdAt);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                _StepIcon(step: step),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: connectorColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.titleKey.tr,
                    style: Get.theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Get.theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                    ),
                  ],
                  if (changedBy != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'orderUpdatedBy'.trParams({'name': changedBy}),
                      style: Get.theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                  if (timestamp.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      timestamp,
                      style: Get.theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIcon extends StatelessWidget {
  const _StepIcon({required this.step});

  final OrderTrackStepBean step;

  @override
  Widget build(BuildContext context) {
    final isDone = step.isCompleted || step.isActive;
    return isDone ? _buildFilledIcon() : _buildOutlinedIcon();
  }

  Widget _buildFilledIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: _fillColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: _statusIcon(color: Colors.white, size: 14),
    ).animateScaleIn(begin: 0.6);
  }

  Color get _fillColor {
    switch (step.icon) {
      case OrderTrackStepIcon.canceled:
        return const Color(0xFFC62828);
      case OrderTrackStepIcon.returned:
        return const Color(0xFF7B1FA2);
      default:
        return AppColors.orderSuccess;
    }
  }

  Widget _buildOutlinedIcon() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border, width: 2),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: _statusIcon(color: AppColors.textSecondary, size: 16),
    );
  }

  Widget _statusIcon({required Color color, required double size}) {
    switch (step.icon) {
      case OrderTrackStepIcon.confirmed:
        return SvgPicture.asset(
          'assets/icons/ic_check.svg',
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case OrderTrackStepIcon.preparing:
        return Icon(Icons.schedule, size: size, color: color);
      case OrderTrackStepIcon.shipped:
        return Icon(Icons.local_shipping_outlined, size: size, color: color);
      case OrderTrackStepIcon.delivered:
        return Icon(Icons.home_outlined, size: size, color: color);
      case OrderTrackStepIcon.returned:
        return SvgPicture.asset(
          'assets/icons/ic_retry.svg',
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      case OrderTrackStepIcon.canceled:
        return Icon(Icons.close, size: size, color: color);
      case OrderTrackStepIcon.pending:
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
    }
  }
}
