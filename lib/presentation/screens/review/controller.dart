import 'package:get/get.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/app/use_cases/reviews_use_case.dart';
import 'package:hedma/domain/models/beans/order_line_item_bean.dart';
import 'package:hedma/domain/models/enums/review_size_fit.dart';
import 'package:hedma/domain/requests/add_review_request.dart';
import 'package:hedma/domain/requests/order_details_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';
import 'package:hedma/presentation/screens/review/models/order_item_review_draft.dart';

class ReviewController extends BaseController {
  final ReviewsUseCase _reviewsUseCase = Get.put(ReviewsUseCase());
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final itemReviews = <OrderItemReviewDraft>[].obs;

  late final int orderId;

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments['orderId'];
    final order = Get.arguments['order'];
    final items = Get.arguments['items'];

    if (items != null && items.isNotEmpty) {
      _setItemReviews(items);
    } else if (order != null && order.items.isNotEmpty) {
      _setItemReviews(order.items);
    } else {
      requestOrderDetails();
    }
  }

  @override
  void onClose() {
    for (final draft in itemReviews) {
      draft.dispose();
    }
    super.onClose();
  }

  void _setItemReviews(List<OrderLineItemBean> items) {
    itemReviews.assignAll(
      items.map((item) => OrderItemReviewDraft(item: item)),
    );
  }

  Future<void> requestOrderDetails() async {
    isLoading.value = true;
    final response = await _orderUseCase.requestOrderDetails(
      OrderDetailsRequest(orderId: orderId),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    final items = response.data?.items ?? [];
    if (items.isEmpty) {
      Get.rawSnackbar(message: 'noItemsToReview'.tr);
      return;
    }
    _setItemReviews(items);
  }

  void selectSizeFit(int index, ReviewSizeFit fit) {
    itemReviews[index].selectedSizeFit.value = fit;
  }

  void selectRating(int index, int rating) {
    itemReviews[index].selectedRating.value = rating;
  }

  Future<void> requestAddReview() async {
    if (itemReviews.isEmpty) return;

    for (var i = 0; i < itemReviews.length; i++) {
      final draft = itemReviews[i];
      if (draft.selectedRating.value <= 0) {
        Get.rawSnackbar(
          message: 'ratingRequiredForItem'.trParams({'index': '${i + 1}'}),
        );
        return;
      }
      Get.rawSnackbar(message: 'reviewItemInvalid'.tr);
    }

    isLoading.value = true;
    for (final draft in itemReviews) {
      final response = await _reviewsUseCase.requestAddReview(
        AddReviewRequest(
          productId: draft.item.productId,
          orderItemId: draft.item.id,
          sizeFit: draft.selectedSizeFit.value,
          rating: draft.selectedRating.value,
          comment: draft.commentController.text.trim(),
        ),
      );
      if (!isSuccess(response)) {
        isLoading.value = false;
        return;
      }
    }
    isLoading.value = false;

    Get.back();
    Get.rawSnackbar(message: 'reviewSubmitted'.tr);
  }
}
