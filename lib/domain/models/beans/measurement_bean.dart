class MeasurementBean {
  final int? id;
  final String? label;
  final String? value;
  final String? unit;

  const MeasurementBean({
    required this.id,
    required this.label,
    required this.value,
    required this.unit,
  });

  factory MeasurementBean.fromJson(Map<String, dynamic> json) {
    return MeasurementBean(
      id: json['id'],
      label: json['key']?.toString() ?? json['label']?.toString(),
      value: json['value']?.toString(),
      unit: json['unit']?.toString(),
    );
  }

  String get displayValue {
    final raw = value?.trim() ?? '';
    if (raw.isEmpty) return '-';
    final u = unit?.trim();
    if (u == null || u.isEmpty) return raw;
    return '$raw $u';
  }
}
