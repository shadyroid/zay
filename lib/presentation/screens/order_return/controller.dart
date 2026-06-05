import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/domain/models/beans/return_reason_bean.dart';
import 'package:hedma/domain/requests/order_return_request.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class OrderReturnController extends BaseController {
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final notesController = TextEditingController();
  final reasons = <ReturnReasonBean>[].obs;
  final selectedReasonValue = RxnString();
  final returnPolicy = RxnString();

  late final int orderId;

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments['orderId'];
    requestReturnReasons();
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  Future<void> requestReturnReasons() async {
    isLoading.value = true;
    final response = await _orderUseCase.requestReturnReasons();
    isLoading.value = false;
    if (!isSuccess(response)) return;

    reasons.assignAll(response.data ?? []);
    returnPolicy.value = response.returnPolicy;
    if (reasons.isNotEmpty && selectedReasonValue.value == null) {
      selectedReasonValue.value = reasons.first.value;
    }
  }

  void selectReason(ReturnReasonBean reason) {
    selectedReasonValue.value = reason.value;
  }

  Future<void> requestOrderReturn() async {
    final reason = selectedReasonValue.value;
    if (reason == null || reason.isEmpty) return;

    isLoading.value = true;
    final response = await _orderUseCase.requestOrderReturn(
      OrderReturnRequest(
        orderId: orderId,
        reason: reason,
        description: notesController.text.trim(),
      ),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.back();
    Get.rawSnackbar(message: response.message ?? 'returnSubmitted'.tr);
  }
}
