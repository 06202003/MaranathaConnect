// domain/usecases/pdf_usecase.dart
import 'package:flutter_firebase/features/domain/entities/pdf_entity.dart';
import 'package:flutter_firebase/features/domain/repositories/pdf_repository.dart';

class PdfUseCase {
  final PdfRepository _repository;

  PdfUseCase(this._repository);

  Future<void> uploadPdf(String title, String filePath) {
    return _repository.uploadPdf(title, filePath);
  }

  Future<List<PdfEntity>> getPdfList() {
    return _repository.getPdfList();
  }

  Future<void> openPdf(String url) {
    return _repository.openPdf(url);
  }
}
