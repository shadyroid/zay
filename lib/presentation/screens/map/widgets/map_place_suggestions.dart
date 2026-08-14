import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zay/app/utils/app_colors.dart';
import 'package:zay/domain/models/beans/location_bean.dart';

class MapPlaceSuggestions extends StatelessWidget {
  const MapPlaceSuggestions({
    super.key,
    required this.locations,
    required this.onSelect,
  });

  final List<LocationBean> locations;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: locations.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: AppColors.border,
        ),
        itemBuilder: (context, index) {
          final location = locations[index];

          return Material(
            type: MaterialType.transparency,
            child: ListTile(
              dense: true,
              title: Text(
                location.address ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Get.theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () => onSelect(index),
            ),
          );
        },
      ),
    );
  }
}
