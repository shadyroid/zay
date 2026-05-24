class SizeBean {
  final String id;
  final String label;

  const SizeBean({
    required this.id,
    required this.label,
  });

  factory SizeBean.fromJson(Map<String, dynamic> json) {
    return SizeBean(
      id: json['id']?.toString() ?? '',
      label: json['label'] as String? ?? json['name'] as String? ?? '',
    );
  }
}
