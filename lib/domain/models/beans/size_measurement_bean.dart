class SizeMeasurementBean {
  final String id;
  final String label;
  final String value;

  const SizeMeasurementBean({
    required this.id,
    required this.label,
    required this.value,
  });

  factory SizeMeasurementBean.fromJson(Map<String, dynamic> json) {
    return SizeMeasurementBean(
      id: json['id']?.toString() ?? '',
      label: json['label'] as String? ?? '',
      value: json['value']?.toString() ?? '',
    );
  }
}
