import 'package:flutter/material.dart';
import 'package:hedma/app/utils/app_colors.dart';
import 'package:hedma/domain/models/beans/product_bean.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ProductBean product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: const Icon(Icons.shopping_bag_outlined),
      ),
      title: Text(product.name),
      subtitle: Text('\$${product.price}'),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}
