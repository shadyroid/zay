//Done Review Need BE Edits
class TypeBean {
  final String? id;
  final String? name;

  const TypeBean({required this.id, required this.name});

  factory TypeBean.fromJson(Map<String, dynamic> json) {
    return TypeBean(id: json['id'], name: json['name']);
  }

  static List<TypeBean> get values {
    return [
      TypeBean.fromJson({"id": "tops", "name": "imageCategoryTop"}),
      TypeBean.fromJson({"id": "bottoms", "name": "imageCategoryBottom"}),
    ];
  }
}
