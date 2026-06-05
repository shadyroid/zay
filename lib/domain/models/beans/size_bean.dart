import 'package:hedma/domain/models/beans/measurement_bean.dart';

class SizeBean {
  final int? id;
  final String? label;
  final String? price;
  final bool? isAvailable;
  final List<MeasurementBean>? measurements;

  const SizeBean({
    required this.id,
    required this.label,
    required this.price,
    required this.isAvailable,
    required this.measurements,
  });

  factory SizeBean.fromJson(Map<String, dynamic> json) {
    return SizeBean(
      id: json['id'],
      label: json['label'],
      price: json['price'],
      isAvailable: json['is_available'],
      measurements: (json['measurements'] as List?)?.map((e) => MeasurementBean.fromJson(e)).toList(),
    );
  }
}
