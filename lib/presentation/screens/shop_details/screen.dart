import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/shop_bean.dart';
import 'package:hedma/presentation/screens/shop_details/controller.dart';
import 'package:hedma/presentation/screens/shop_details/widgets/shop_about_section.dart';
import 'package:hedma/presentation/screens/shop_details/widgets/shop_banner_header.dart';
import 'package:hedma/presentation/screens/shop_details/widgets/shop_details_app_bar.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';
import 'package:hedma/presentation/widgets/category_item.dart';
import 'package:hedma/presentation/widgets/product_grid_item.dart';

class ShopDetailsScreen extends GetView<ShopDetailsController> {
  const ShopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final shop = controller.shop.value;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: ShopDetailsAppBar(
          title: shop?.name ?? 'shops'.tr,
          onShare: controller.onShare,
        ),
        body: _buildBody(shop),
      );
    });
  }

  Widget _buildBody(ShopBean? shop) {
    if (controller.isLoading.value && shop == null) {
      return const Center(child: AppProgressIndicator());
    }
    if (shop == null) {
      return const SizedBox.shrink();
    }

    final rating = shop.rating ?? '4.5';
    final reviewCount = shop.reviewsCount ?? 0;
    final tagline = shop.description ?? '';
    final about = shop.slogan ?? shop.description ?? '';

    return Obx(
      () => CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: ShopBannerHeader(shop: shop)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  shop.name ?? "",
                  style: Get.theme.textTheme.titleLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ic_star.svg',
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: Get.theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '($reviewCount ${'reviews'.tr})',
                      style: Get.theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (tagline.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    tagline,
                    style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                ShopAboutSection(
                  about: about,
                  isExpanded: controller.isAboutExpanded.value,
                  onReadMore: controller.toggleAboutExpanded,
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
          if (controller.shop.value?.categories?.isNotEmpty == true) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'categories'.tr,
                  style: Get.theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.shop.value?.categories?.length,
                  itemBuilder: (context, index) {
                    final category = controller.shop.value!.categories![index];
                    return CategoryItem(
                      category: category,
                      isSelected:
                          controller.selectedCategoryId.value == category.id,
                      onTap: () => controller.selectCategory(category),
                    );
                  },
                ),
              ),
            ),
          ],

          if (controller.bestSellerProducts.isNotEmpty) ...[
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text(
                      'bestSeller'.tr,
                      style: Get.theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: controller.navigateToAllProducts,
                      child: Text(
                        'seeAll'.tr,
                        style: Get.theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final product = controller.bestSellerProducts[index];
                  return ProductGridItem(
                    product: product,
                    isFavorite: product.isFavorite,
                    onTap: () => controller.navigateToProductDetails(product),
                    onFavoriteTap: () async {
                      await controller.toggleFavorite(product);
                    },
                  );
                }, childCount: controller.bestSellerProducts.length),
              ),
            ),
          ],
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
