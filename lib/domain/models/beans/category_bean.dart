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
    final image = json['image'] as String?;
    final icon = json['icon'] as String? ?? json['iconUrl'] as String?;

    return CategoryBean(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      iconUrl: image ?? icon ?? json['iconPath'] as String? ?? '',
    );
  }

  static const CategoryBean all = CategoryBean(
    id: 'all',
    name: 'All Items',
    iconUrl: '',
  );

  static List<CategoryBean> parseFlattenedList(List<dynamic>? raw) {
    if (raw == null) return [CategoryBean.all];

    final result = <CategoryBean>[CategoryBean.all];
    for (final item in raw) {
      if (item is! Map<String, dynamic>) continue;
      result.add(CategoryBean.fromJson(item));
      final children = item['children'] as List<dynamic>?;
      if (children == null) continue;
      for (final child in children) {
        if (child is Map<String, dynamic>) {
          result.add(CategoryBean.fromJson(child));
        }
      }
    }
    return result;
  }
}
