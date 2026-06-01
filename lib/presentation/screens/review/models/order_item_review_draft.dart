import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/domain/models/beans/order_line_item_bean.dart';
import 'package:hedma/domain/models/enums/review_size_fit.dart';

class OrderItemReviewDraft {
  OrderItemReviewDraft({required this.item})
      : commentController = TextEditingController(),
        selectedSizeFit = ReviewSizeFit.good.obs,
        selectedRating = 0.obs;

  final OrderLineItemBean item;
  final TextEditingController commentController;
  final Rx<ReviewSizeFit> selectedSizeFit;
  final RxInt selectedRating;

  void dispose() => commentController.dispose();
}
