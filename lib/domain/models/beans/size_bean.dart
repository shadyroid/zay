class SizeBean {
  final int? id;
  final String? label;

  const SizeBean({
    required this.id,
    required this.label,
  });

  factory SizeBean.fromJson(Map<String, dynamic> json) {
    return SizeBean(
      id: json['id'],
      label: json['label'],
    );
  }
}
