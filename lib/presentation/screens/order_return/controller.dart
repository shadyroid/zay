import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/app/use_cases/order_use_case.dart';
import 'package:hedma/presentation/base/base_controller.dart';

class OrderReturnController extends BaseController {
  final OrderUseCase _orderUseCase = Get.put(OrderUseCase());

  final formKey = GlobalKey<FormState>();
  final reasonController = TextEditingController();
  late final String orderId;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    orderId = args['orderId'] as String? ?? '';
  }

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }

  Future<void> requestOrderReturn() async {
    if (formKey.currentState?.validate() != true) return;
    if (orderId.isEmpty) return;

    isLoading.value = true;
    final response = await _orderUseCase.requestOrderReturn(
      orderId: orderId,
      reason: reasonController.text.trim(),
    );
    isLoading.value = false;
    if (!isSuccess(response)) return;

    Get.back();
    Get.rawSnackbar(message: response.message?.tr ?? 'returnSubmitted'.tr);
  }
}
