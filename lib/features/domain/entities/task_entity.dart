class TaskEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String date;

  TaskEntity(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.date});

  factory TaskEntity.fromFirestoreData(Map<String, dynamic> data) {
    return TaskEntity(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      date: data['date'] ?? '',
    );
  }
}
