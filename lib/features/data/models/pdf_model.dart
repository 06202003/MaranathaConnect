// data/models/pdf_model.dart
class PdfModel {
  final String id;
  final String title;
  final String url;

  PdfModel({required this.id, required this.title, required this.url});

  factory PdfModel.fromMap(Map<String, dynamic> map) {
    return PdfModel(
      id: map['id'],
      title: map['title'],
      url: map['url'],
    );
  }
}
