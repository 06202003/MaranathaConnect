import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/domain/usecases/pdf_usecase.dart';

class PdfUploadScreen extends StatelessWidget {
  final PdfUseCase pdfUseCase;

  PdfUploadScreen({required this.pdfUseCase});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload PDF'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Implementasi logika untuk mengupload PDF
                // Anda mungkin perlu menggunakan plugin file_picker atau sejenisnya
                // dan kemudian memanggil pdfUseCase.uploadPdf untuk mengunggah PDF

                // Contoh menggunakan data dummy
                final String title = 'Dummy Uploaded PDF';
                final String url = 'https://dummy-url.com/uploaded-pdf';

                // Gantilah baris di bawah ini dengan logika sesuai kebutuhan Anda
                pdfUseCase.uploadPdf(title, url);

                // Tampilkan notifikasi atau feedback kepada pengguna jika diperlukan
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('PDF uploaded successfully!'),
                  ),
                );
              },
              child: Text('Upload PDF'),
            ),
            SizedBox(height: 16.0),
            // Tambahkan komponen lain sesuai kebutuhan, misalnya form untuk mengisi informasi PDF
          ],
        ),
      ),
    );
  }
}
