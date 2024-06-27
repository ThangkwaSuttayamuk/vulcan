class OrderEntity {
  final int? id;
  final String? address;
  final String? tel;
  final String orderDate;

  OrderEntity(
      {this.id,
      required this.orderDate,
      required this.address,
      required this.tel});

  factory OrderEntity.fromMap(Map<String, dynamic> map) {
    return OrderEntity(
      id: map['id'] ?? 0,
      address: map['address'] ?? '',
      tel: map['tel'] ?? '',
      orderDate: map['order_date'],
    );
  }
}
