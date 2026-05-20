import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/domain/models/beans/order_track_step_bean.dart';
import 'package:hedma/domain/models/enums/order_track_step_icon.dart';

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
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  if (step.subtitleKey.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      step.subtitleKey.tr,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                    ),
                  ],
                  if (step.timestamp.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      step.timestamp,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

    if (isDone) {
      return _buildFilledIcon();
    }
    return _buildOutlinedIcon();
  }

  Widget _buildFilledIcon() {
    Widget child;
    switch (step.icon) {
      case OrderTrackStepIcon.confirmed:
        child = SvgPicture.asset(
          AppIcons.check,
          width: 14,
          height: 14,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        );
      case OrderTrackStepIcon.pending:
        child = Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        );
      default:
        child = Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        );
    }

    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: AppColors.orderSuccess,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }

  Widget _buildOutlinedIcon() {
    Widget child;
    switch (step.icon) {
      case OrderTrackStepIcon.shipped:
        child = Icon(
          Icons.local_shipping_outlined,
          size: 16,
          color: AppColors.textSecondary,
        );
      case OrderTrackStepIcon.delivered:
        child = Icon(
          Icons.home_outlined,
          size: 16,
          color: AppColors.textSecondary,
        );
      case OrderTrackStepIcon.returned:
        child = SvgPicture.asset(
          AppIcons.retry,
          width: 16,
          height: 16,
          colorFilter: const ColorFilter.mode(
            AppColors.textSecondary,
            BlendMode.srcIn,
          ),
        );
      default:
        child = Icon(
          Icons.circle_outlined,
          size: 16,
          color: AppColors.textSecondary,
        );
    }

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border, width: 2),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
