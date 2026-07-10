import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/presentation/screens/privacy/controller.dart';
import 'package:zay/presentation/widgets/html_content_scaffold.dart';

class PrivacyScreen extends GetView<PrivacyController> {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HtmlContentScaffold(
        title: 'privacy'.tr,
        html: controller.content.value,
        isLoading: controller.isLoading.value,
      ),
    );
  }
}
