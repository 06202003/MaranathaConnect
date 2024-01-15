// domain/repositories/pdf_repository.dart
import 'package:flutter_firebase/features/domain/entities/pdf_entity.dart';

abstract class PdfRepository {
  Future<void> uploadPdf(String title, String filePath);
  Future<List<PdfEntity>> getPdfList();
  Future<void> openPdf(String url);
}
