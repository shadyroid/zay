import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:zay/presentation/screens/about_us/controller.dart';
import 'package:zay/presentation/widgets/html_content_scaffold.dart';

class AboutUsScreen extends GetView<AboutUsController> {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => HtmlContentScaffold(
        title: 'aboutUs'.tr,
        html: controller.content.value,
        isLoading: controller.isLoading.value,
      ),
    );
  }
}
