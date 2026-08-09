import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/presentation/screens/try_on/controller.dart';
import 'package:zay/presentation/screens/try_on/widgets/try_on_app_bar.dart';
import 'package:zay/presentation/screens/try_on/widgets/try_on_bottom_bar.dart';
import 'package:zay/presentation/screens/try_on/widgets/try_on_fee_card.dart';
import 'package:zay/presentation/screens/try_on/widgets/try_on_feedback_section.dart';
import 'package:zay/presentation/widgets/app_image.dart';
import 'package:zay/presentation/widgets/app_progress_indicator.dart';

class TryOnScreen extends GetView<TryOnController> {
  const TryOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TryOnAppBar(
        onShare: controller.onShare,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.imageUrl.value == null) {
          return const Center(child: AppProgressIndicator());
        }

        final url = controller.imageUrl.value;
        final price = controller.product.price;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (url!=null)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                AppImage.network(
                                  url,
                                  fit: BoxFit.cover,
                                  errorWidget: _imagePlaceholder(),
                                  viewerImages: [url],
                                ),
                                if (controller.isLoading.value)
                                  const ColoredBox(
                                    color: Color(0x66000000),
                                    child: Center(
                                      child: AppProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: _imagePlaceholder(),
                        ),
                      ),
                    const SizedBox(height: 8),
                    TryOnFeedbackSection(
                      selectedRating: controller.selectedRating.value,
                      onRatingSelected: controller.selectRating,
                    ),
                    const SizedBox(height: 20),
                    const TryOnFeeCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            TryOnBottomBar(
              price: price,
              onTryOnAgain: controller.onTryOnAgain,
              onAddToCart: controller.onAddToCart,
            ),
          ],
        );
      }),
    );
  }

  Widget _imagePlaceholder() {
    return ColoredBox(
      color: AppColors.screenBackground,
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/ic_product_placeholder.svg',
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
