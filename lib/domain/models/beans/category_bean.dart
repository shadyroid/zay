class CategoryBean {
  final int? id;
  final String? name;
  final String? iconUrl;

  const CategoryBean({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  factory CategoryBean.fromJson(Map<String, dynamic> json) {
    return CategoryBean(
      id: json['id'],
      name: json['name'],
      iconUrl: json['icon'],
    );
  }


}
