import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_motion.dart';
import 'package:zay/presentation/screens/shops/controller.dart';
import 'package:zay/presentation/screens/shops/widgets/shop_item.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class ShopsScreen extends GetView<ShopsController> {
  const ShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithSearchSwitch(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.textPrimary,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        centerTitle: true,
        appBarBuilder: (context) {
          return AppBar(
            title: Text(
              'stores'.tr,
              style: Get.theme.textTheme.titleMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () =>
                    AppBarWithSearchSwitch.of(context)?.triggerSearch(),
                icon: SvgPicture.asset(
                  'assets/icons/ic_search.svg',
                  width: 22,
                  height: 22,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          );
        },

        onChanged: controller.onSearch,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, thickness: 1, color: AppColors.border),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppProgressIndicator());
        }
        return AnimatedStateSwitcher(
          child: ListView.separated(
            key: ValueKey(controller.shops.length),
            itemCount: controller.shops.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              thickness: 1,
              color: AppColors.border,
            ),
            itemBuilder: (_, index) {
              final shop = controller.shops[index];
              return ShopItem(
                shop: shop,
                onTap: () => controller.navigateToShopDetails(shop),
              ).animateStagger(index);
            },
          ),
        );
      }),
    );
  }
}
