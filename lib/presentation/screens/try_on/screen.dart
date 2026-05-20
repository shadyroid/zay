import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/presentation/screens/try_on/controller.dart';
import 'package:hedma/presentation/screens/try_on/widgets/try_on_app_bar.dart';
import 'package:hedma/presentation/screens/try_on/widgets/try_on_bottom_bar.dart';
import 'package:hedma/presentation/screens/try_on/widgets/try_on_fee_card.dart';
import 'package:hedma/presentation/screens/try_on/widgets/try_on_feedback_section.dart';

class TryOnScreen extends GetView<TryOnController> {
  const TryOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TryOnAppBar(
        onBack: controller.goBack,
        onShare: controller.onShare,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.imageUrl.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final url = controller.imageUrl.value;
        final price = controller.productPrice.value;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (url.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      _imagePlaceholder(),
                                ),
                                if (controller.isLoading.value)
                                  const ColoredBox(
                                    color: Color(0x66000000),
                                    child: Center(
                                      child: CircularProgressIndicator(
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
              price: price.isNotEmpty ? price : '0',
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
          AppIcons.productPlaceholder,
          width: 80,
          height: 80,
        ),
      ),
    );
  }
}
