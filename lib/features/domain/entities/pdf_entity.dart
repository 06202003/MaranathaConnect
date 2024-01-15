import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

class PdfEntity {
  final String id;
  final String judul;
  final String penulis;
  final String deskripsi;
  final String assetPath; // Asset path for PDF

  PdfEntity({
    required this.id,
    required this.judul,
    required this.penulis,
    required this.deskripsi,
    required this.assetPath,
  });

  Future<Uint8List> getPdfBytes() async {
    try {
      ByteData data = await rootBundle.load(assetPath);
      return data.buffer.asUint8List();
    } catch (e) {
      // Handle errors, e.g., show a Snackbar or log the error.
      throw Exception('Error loading PDF bytes: $e');
    }
  }
}
