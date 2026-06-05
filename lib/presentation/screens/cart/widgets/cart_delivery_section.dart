import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/app/utils/app_input_formatters.dart';
import 'package:hedma/app/utils/egyptian_phone_util.dart';
import 'package:hedma/presentation/widgets/app_text_field.dart';

class CartDeliverySection extends StatelessWidget {
  const CartDeliverySection({
    super.key,
    required this.formKey,
    required this.locationText,
    required this.mobileController,
    required this.onSelectLocation,
  });

  final GlobalKey<FormState> formKey;
  final String? locationText;
  final TextEditingController mobileController;
  final VoidCallback onSelectLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.screenBackground,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Form(
        key: formKey,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/icons/ic_location.svg', width: 22, height: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        locationText?.isNotEmpty == true
                            ? locationText!
                            : 'selectLocation'.tr,
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: locationText?.isNotEmpty == true
                                      ? AppColors.textPrimary
                                      : AppColors.hint,
                                ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: mobileController,
              hint: 'mobileNumber'.tr,
              prefixIconPath: 'assets/icons/ic_phone',
              keyboardType: TextInputType.phone,
              inputFormatters: AppInputFormatters.phone,
              textInputAction: TextInputAction.done,
              validator: (v) => EgyptianPhoneUtil.validate(v, required: true),
            ),
          ],
        ),
      ),
    );
  }
}
