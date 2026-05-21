import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hedma/presentation/screens/terms/controller.dart';
import 'package:hedma/presentation/widgets/html_content_scaffold.dart';

class TermsScreen extends GetView<TermsController> {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HtmlContentScaffold(
        title: 'terms'.tr,
        html: controller.content.value,
        isLoading: controller.isLoading.value,
      ),
    );
  }
}
