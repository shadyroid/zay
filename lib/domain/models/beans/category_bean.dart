class CategoryBean {
  final String id;
  final String name;
  final String iconUrl;

  const CategoryBean({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  factory CategoryBean.fromJson(Map<String, dynamic> json) {
    return CategoryBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      iconUrl: json['iconUrl'] as String? ?? json['iconPath'] as String? ?? '',
    );
  }
}
