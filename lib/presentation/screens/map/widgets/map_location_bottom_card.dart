import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/presentation/widgets/app_button.dart';
import 'package:hedma/presentation/widgets/app_progress_indicator.dart';

class MapLocationBottomCard extends StatelessWidget {
  const MapLocationBottomCard({
    super.key,
    required this.address,
    required this.isLoading,
    required this.onPickLocation,
  });

  final String address;
  final bool isLoading;
  final VoidCallback onPickLocation;

  @override
  Widget build(BuildContext context) {
    final hasAddress = address.isNotEmpty;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/icons/ic_location.svg',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: isLoading && !hasAddress
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: AppProgressIndicator(
                            color: AppColors.secondary,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hasAddress
                                  ? address
                                  : 'selectLocation'.tr,
                              style: Get.theme
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppButton(
              text: 'pickLocation'.tr,
              backgroundColor: AppColors.secondary,
              isLoading: isLoading,
              onPressed: isLoading ? null : onPickLocation,
            ),
          ],
        ),
      ),
    );
  }
}
