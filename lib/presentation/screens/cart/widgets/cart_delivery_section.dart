import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/app/utils/app_input_formatters.dart';
import 'package:zay/app/utils/egyptian_phone_util.dart';
import 'package:zay/domain/models/beans/city_bean.dart';
import 'package:zay/presentation/widgets/app_text_field.dart';

class CartDeliverySection extends StatelessWidget {
  const CartDeliverySection({
    super.key,
    required this.formKey,
    required this.locationText,
    required this.cities,
    required this.selectedCity,
    required this.showCityPicker,
    required this.mobileController,
    required this.onSelectLocation,
    required this.onCitySelected,
  });

  final GlobalKey<FormState> formKey;
  final String? locationText;
  final List<CityBean> cities;
  final CityBean? selectedCity;
  final bool showCityPicker;
  final TextEditingController mobileController;
  final VoidCallback onSelectLocation;
  final ValueChanged<CityBean?> onCitySelected;

  @override
  Widget build(BuildContext context) {
    final selectedCityId = cities.any((city) => city.id == selectedCity?.id)
        ? selectedCity?.id
        : null;

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
              style: Get.theme.textTheme.titleSmall?.copyWith(
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
                            Get.theme.textTheme.bodyMedium?.copyWith(
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
            if (showCityPicker) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                key: ValueKey(selectedCityId),
                initialValue: selectedCityId,
                isExpanded: true,
                decoration: InputDecoration(
                  hintText: 'selectCity'.tr,
                  hintStyle: const TextStyle(color: AppColors.hint),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
                items: cities
                    .map(
                      (city) => DropdownMenuItem<int>(
                        value: city.id,
                        child: Text(city.displayName),
                      ),
                    )
                    .toList(),
                onChanged: (id) {
                  if (id == null) {
                    onCitySelected(null);
                    return;
                  }
                  for (final city in cities) {
                    if (city.id == id) {
                      onCitySelected(city);
                      return;
                    }
                  }
                },
                validator: (value) =>
                    value == null ? 'cityRequired'.tr : null,
              ),
            ],
            const SizedBox(height: 12),
            AppTextField(
              controller: mobileController,
              hint: 'mobileNumber'.tr,
              prefixIconPath: 'assets/icons/ic_phone.svg',
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
