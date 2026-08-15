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
import 'package:zay/presentation/widgets/staged_loading_view.dart';

class TryOnScreen extends GetView<TryOnController> {
  const TryOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.isLoading.value;

      return Scaffold(
        backgroundColor:
            isLoading ? StagedLoadingView.background : Colors.white,
        appBar: isLoading
            ? null
            : TryOnAppBar(
                onShare: controller.onShare,
              ),
        body: isLoading
            ? StagedLoadingView.tryOn(
                sendProgress: controller.sendProgress.value,
                receiveProgress: controller.receiveProgress.value,
              )
            : _buildContent(),
      );
    });
  }

  Widget _buildContent() {
    final url = controller.imageUrl.value;
    final price = controller.product.price;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (url != null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AppImage.network(
                          url,
                          fit: BoxFit.cover,
                          errorWidget: _imagePlaceholder(),
                          viewerImages: [url],
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
                TryOnFeeCard(
                  allowedTriesToday: controller.allowedTriesToday.value,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        TryOnBottomBar(
          price: price,
          canTryOnAgain: (controller.allowedTriesToday.value ?? 1) > 0,
          onTryOnAgain: controller.onTryOnAgain,
          onAddToCart: controller.onAddToCart,
        ),
      ],
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
