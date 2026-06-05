class MeasurementBean {
  final int? id;
  final String? label;
  final String? value;

  const MeasurementBean({
    required this.id,
    required this.label,
    required this.value,
  });

  factory MeasurementBean.fromJson(Map<String, dynamic> json) {
    return MeasurementBean(
      id: json['id'],
      label: json['key'],
      value: json['value'],
    );
  }
}
