import 'package:hedma/domain/models/beans/size_measurement_bean.dart';

class ProductSizeBean {
  final String id;
  final String label;
  final List<SizeMeasurementBean> measurements;

  const ProductSizeBean({
    required this.id,
    required this.label,
    this.measurements = const [],
  });

  factory ProductSizeBean.fromJson(Map<String, dynamic> json) {
    final list = json['measurements'] as List<dynamic>?;
    return ProductSizeBean(
      id: json['id']?.toString() ?? '',
      label: json['label'] as String? ?? '',
      measurements: list
              ?.map(
                (e) => SizeMeasurementBean.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }
}
