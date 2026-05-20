class ReviewBean {
  final String id;
  final String title;
  final String comment;
  final String authorName;
  final double rating;
  final String createdAt;

  const ReviewBean({
    required this.id,
    required this.title,
    required this.comment,
    required this.authorName,
    required this.rating,
    required this.createdAt,
  });

  factory ReviewBean.fromJson(Map<String, dynamic> json) {
    return ReviewBean(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      comment: json['comment'] as String? ?? '',
      authorName: json['authorName'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      createdAt: json['createdAt'] as String? ?? '',
    );
  }
}
