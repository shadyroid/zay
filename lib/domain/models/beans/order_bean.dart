class OrderBean {
  final String id;
  final String status;
  final String total;
  final String date;
  final int itemCount;

  const OrderBean({
    required this.id,
    required this.status,
    required this.total,
    required this.date,
    required this.itemCount,
  });

  factory OrderBean.fromJson(Map<String, dynamic> json) {
    return OrderBean(
      id: json['id']?.toString() ?? '',
      status: json['status'] as String? ?? '',
      total: json['total']?.toString() ?? '0',
      date: json['date'] as String? ?? '',
      itemCount: json['itemCount'] as int? ?? 0,
    );
  }
}
