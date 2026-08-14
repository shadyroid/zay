class ReviewBean {
  final int? id;
  final String? title;
  final String? comment;
  final String? authorName;
  final double? rating;
  final String? createdAt;

  const ReviewBean({
    required this.id,
    required this.title,
    required this.comment,
    required this.authorName,
    required this.rating,
    required this.createdAt,
  });

  factory ReviewBean.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;

    return ReviewBean(
      id: json['id'],
      title: json['title'],
      comment: json['comment'],
      authorName: user?['name'] as String? ?? json['authorName'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      createdAt: json['created_at'] as String? ?? json['createdAt'],
    );
  }
}
