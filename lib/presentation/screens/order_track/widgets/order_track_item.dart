import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';

class OrderTrackItem extends StatelessWidget {
  const OrderTrackItem({
    super.key,
    required this.title,
    required this.isActive,
  });

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isActive ? Icons.check_circle : Icons.radio_button_unchecked,
        color: isActive ? AppColors.secondary : Colors.grey,
      ),
      title: Text(title),
    );
  }
}
