class SizeMeasurementBean {
  final int? id;
  final String? label;
  final String? value;

  const SizeMeasurementBean({
    required this.id,
    required this.label,
    required this.value,
  });

  factory SizeMeasurementBean.fromJson(Map<String, dynamic> json) {
    return SizeMeasurementBean(
      id: json['id'],
      label: json['label'],
      value: json['value'],
    );
  }
}
