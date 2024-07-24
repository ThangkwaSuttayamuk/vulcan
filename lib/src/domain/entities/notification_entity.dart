class NotificationEntity {
  final int? id;
  final String? title;
  final String? period;
  final String? description;
  final String? image;

  NotificationEntity(
      {required this.id,
      required this.title,
      required this.period,
      required this.description,
      required this.image});

  factory NotificationEntity.fromMap(Map<String, dynamic> map) {
    return NotificationEntity(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      period: map['period'] ?? '',
      description: map['description'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
