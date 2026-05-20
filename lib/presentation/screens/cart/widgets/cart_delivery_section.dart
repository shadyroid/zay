import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_icons.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';

class CartDeliverySection extends StatelessWidget {
  const CartDeliverySection({
    super.key,
    required this.locationText,
    required this.mobileController,
    required this.onSelectLocation,
  });

  final String? locationText;
  final TextEditingController mobileController;
  final VoidCallback onSelectLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.screenBackground,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'orderDeliveryLocation'.tr,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onSelectLocation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppIcons.location, width: 22, height: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      locationText?.isNotEmpty == true
                          ? locationText!
                          : 'selectLocation'.tr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: locationText?.isNotEmpty == true
                                ? AppColors.textPrimary
                                : AppColors.hint,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SvgPicture.asset(
                    AppIcons.chevronRight,
                    width: 18,
                    height: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: mobileController,
            hint: 'mobileNumber'.tr,
            prefixIconPath: AppIcons.phone,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
