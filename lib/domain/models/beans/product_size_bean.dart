import 'package:hedma/domain/models/beans/size_measurement_bean.dart';

class ProductSizeBean {
  final String id;
  final String label;
  final String? price;
  final bool isAvailable;
  final List<SizeMeasurementBean> measurements;

  const ProductSizeBean({
    required this.id,
    required this.label,
    this.price,
    this.isAvailable = true,
    this.measurements = const [],
  });

  factory ProductSizeBean.fromJson(Map<String, dynamic> json) {
    final list = json['measurements'] as List<dynamic>?;
    return ProductSizeBean(
      id: json['id']?.toString() ?? '',
      label: json['label'] as String? ?? '',
      price: json['price']?.toString(),
      isAvailable: json['is_available'] as bool? ?? true,
      measurements: list
              ?.map(
                (e) => SizeMeasurementBean.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }
}
