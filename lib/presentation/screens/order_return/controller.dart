import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/domain/models/enums/order_return_reason.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class OrderReturnController extends BaseController {
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final notesController = TextEditingController();
  final selectedReason = OrderReturnReason.wrongSize.obs;

  late final String orderId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    orderId = args['orderId'] as String? ?? '';
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  void selectReason(OrderReturnReason reason) {
    selectedReason.value = reason;
  }

  void goBack() => Get.back();

  Future<void> requestOrderReturn() async {
    if (orderId.isEmpty) return;

    final reasonLabel = selectedReason.value.translationKey.tr;
    final notes = notesController.text.trim();
    final reason = notes.isEmpty ? reasonLabel : '$reasonLabel — $notes';

    isLoading.value = true;
    final response = await _orderUseCase.requestOrderReturn(
      orderId: orderId,
      reason: reason,
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.back();
    Get.rawSnackbar(message: response.message?.tr ?? 'returnSubmitted'.tr);
  }
}
