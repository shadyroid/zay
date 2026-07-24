class NotificationsRequest {
  static const pageSize = 20;

  const NotificationsRequest({required this.page});

  final int page;

  Map<String, dynamic> toJson() => {
        'page': page,
        'page_size': pageSize,
      };
}
