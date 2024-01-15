// data/repositories/pdf_repository_impl.dart
import 'package:flutter_firebase/features/data/datasources/pdf_datasources.dart';
import 'package:flutter_firebase/features/domain/entities/pdf_entity.dart';
import 'package:flutter_firebase/features/domain/repositories/pdf_repository.dart';

class PdfRepositoryImpl implements PdfRepository {
  final PdfDataSource _dataSource;

  PdfRepositoryImpl(this._dataSource);

  @override
  Future<void> uploadPdf(String title, String filePath) async {
    // No need for dummy data
  }

  @override
  Future<List<PdfEntity>> getPdfList() async {
    final pdfList = await _dataSource.getPdfList();
    return pdfList.map((pdf) => PdfEntity(
      id: pdf.id,
      judul: pdf.judul,  // Corrected field name
      penulis: pdf.penulis,  // Corrected field name
      deskripsi: pdf.deskripsi,  // Corrected field name
      assetPath: pdf.assetPath,  // Assuming 'url' in data source represents assetPath
    )).toList();
  }

  @override
  Future<void> openPdf(String url) async {
    // Implement logic to open PDF
    // You might need a PDF viewer plugin or open the PDF URL in the browser
  }
}