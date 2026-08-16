import 'package:zay/domain/models/beans/measurement_bean.dart';

class SizeBean {
  final int? id;
  final String? label;
  final String? price;
  final bool? isAvailable;
  final bool? isOutOfStock;
  final bool? isRecommended;
  final List<MeasurementBean>? measurements;

  const SizeBean({
    required this.id,
    required this.label,
    required this.price,
    required this.isAvailable,
    required this.isOutOfStock,
    required this.isRecommended,
    required this.measurements,
  });

  factory SizeBean.fromJson(Map<String, dynamic> json) {
    return SizeBean(
      id: json['id'],
      label: json['label'],
      price: json['price'],
      isAvailable: json['is_available'],
      isOutOfStock: json['out_of_stock'],
      measurements: (json['measurements'] as List?)?.map((e) => MeasurementBean.fromJson(e)).toList(),
      isRecommended: json['is_recommended'],
    );
  }
}
