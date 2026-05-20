import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/domain/models/beans/order_track_step_bean.dart';
import 'package:hedma/presentation/screens/order_details/widgets/order_details_section_card.dart';
import 'package:hedma/presentation/screens/order_track/widgets/order_track_timeline_item.dart';

class OrderTrackTimelineCard extends StatelessWidget {
  const OrderTrackTimelineCard({
    super.key,
    required this.steps,
  });

  final List<OrderTrackStepBean> steps;

  @override
  Widget build(BuildContext context) {
    return OrderDetailsSectionCard(
      title: 'trackOrderStatus'.tr,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          children: [
            for (var i = 0; i < steps.length; i++)
              OrderTrackTimelineItem(
                step: steps[i],
                isLast: i == steps.length - 1,
                connectorIsActive: steps[i].isCompleted,
              ),
          ],
        ),
      ),
    );
  }
}
