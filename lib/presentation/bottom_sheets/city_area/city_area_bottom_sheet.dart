import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/city_bean.dart';
import 'package:zay/presentation/widgets/app_text_field.dart';

class CityAreaResult {
  const CityAreaResult({required this.city, required this.area});

  final CityBean city;
  final String area;
}

class CityAreaBottomSheet extends StatefulWidget {
  const CityAreaBottomSheet({
    super.key,
    required this.cities,
    this.initialCity,
    this.initialArea,
  });

  final List<CityBean> cities;
  final CityBean? initialCity;
  final String? initialArea;

  static Future<CityAreaResult?> show({
    required List<CityBean> cities,
    CityBean? initialCity,
    String? initialArea,
  }) {
    return Get.bottomSheet<CityAreaResult>(
      CityAreaBottomSheet(
        cities: cities,
        initialCity: initialCity,
        initialArea: initialArea,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  State<CityAreaBottomSheet> createState() => _CityAreaBottomSheetState();
}

class _CityAreaBottomSheetState extends State<CityAreaBottomSheet> {
  late final TextEditingController _areaController;
  final _formKey = GlobalKey<FormState>();
  CityBean? _selectedCity;

  @override
  void initState() {
    super.initState();
    _selectedCity = widget.initialCity;
    _areaController = TextEditingController(text: widget.initialArea ?? '');
  }

  @override
  void dispose() {
    _areaController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    final city = _selectedCity;
    if (city == null) {
      Get.rawSnackbar(message: 'cityRequired'.tr);
      return;
    }
    Get.back(
      result: CityAreaResult(
        city: city,
        area: _areaController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'completeDeliveryDetails'.tr,
                    style: Get.theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'completeDeliveryDetailsHint'.tr,
                    style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'city'.tr,
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<CityBean>(
                    initialValue: _selectedCity,
                    isExpanded: true,
                    decoration: InputDecoration(
                      hintText: 'selectCity'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    items: widget.cities
                        .map(
                          (city) => DropdownMenuItem(
                            value: city,
                            child: Text(city.displayName),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => _selectedCity = value,
                    validator: (value) =>
                        value == null ? 'cityRequired'.tr : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'area'.tr,
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppTextField(
                    controller: _areaController,
                    hint: 'areaHint'.tr,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'areaRequired'.tr;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('apply'.tr),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
