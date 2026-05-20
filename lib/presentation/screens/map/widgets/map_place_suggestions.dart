import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/place_prediction.dart';

class MapPlaceSuggestions extends StatelessWidget {
  const MapPlaceSuggestions({
    super.key,
    required this.predictions,
    required this.onSelect,
  });

  final List<PlacePrediction> predictions;
  final ValueChanged<PlacePrediction> onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: predictions.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
          color: AppColors.border,
        ),
        itemBuilder: (context, index) {
          final prediction = predictions[index];
          final title = prediction.mainText ?? prediction.description;
          final subtitle = prediction.secondaryText;

          return ListTile(
            dense: true,
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
            ),
            subtitle: subtitle == null
                ? null
                : Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
            onTap: () => onSelect(prediction),
          );
        },
      ),
    );
  }
}
