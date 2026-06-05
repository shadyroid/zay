//Done Review Need BE Edits
class CategoryBean {
  final int? id;
  final String? name;
  final String? icon;
  final String? measurementsImage;

  const CategoryBean({
    required this.id,
    required this.name,
    required this.icon,
    required this.measurementsImage,
  });

  factory CategoryBean.fromJson(Map<String, dynamic> json) {
    return CategoryBean(
      id: json['id'],
      name: json['name'],
      icon: 'https://zaymarketplace.online/storage/${json['icon']}',
      measurementsImage: json['measurements_image'],
    );
  }


}
