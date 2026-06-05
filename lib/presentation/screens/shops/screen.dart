import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/screens/shops/controller.dart';
import 'package:hedma/presentation/screens/shops/widgets/shop_item.dart';
import 'package:hedma/presentation/widgets/app_back_app_bar.dart';
import 'package:hedma/presentation/widgets/main_bottom_nav.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class ShopsScreen extends GetView<ShopsController> {
  const ShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBackAppBar(
        title: 'stores'.tr,
        showDivider: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/ic_search.svg',
              width: 22,
              height: 22,
            ),
            onPressed: controller.onSearch,
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: AppProgressIndicator());
          }
          return ListView.separated(
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
              );
            },
          );
        },
      ),
      bottomNavigationBar: const MainBottomNav(currentIndex: 1),
    );
  }
}
