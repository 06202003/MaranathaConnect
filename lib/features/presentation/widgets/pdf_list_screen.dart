import 'dart:io';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer2/advance_pdf_viewer.dart';
import 'package:flutter_firebase/features/domain/entities/pdf_entity.dart';
import 'package:flutter_firebase/features/domain/usecases/pdf_usecase.dart';
import 'package:path_provider/path_provider.dart';

class PdfListScreen extends StatefulWidget {
  final PdfUseCase pdfUseCase;

  PdfListScreen({required this.pdfUseCase});

  @override
  _PdfListScreenState createState() => _PdfListScreenState();
}

class _PdfListScreenState extends State<PdfListScreen> {
  late Future<List<PdfEntity>> pdfList;

  @override
  void initState() {
    super.initState();
    pdfList = widget.pdfUseCase.getPdfList();
  }

  void navigateToProgramKerjaImagesPage() {
    Navigator.pushNamed(context, '/program_kerja_images');
  }

  Future<void> _showPdfDetailDialog(PdfEntity pdfEntity) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(pdfEntity.judul ?? 'No Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Penulis: ${pdfEntity.penulis ?? 'No Author'}'),
                Text('Deskripsi: ${pdfEntity.deskripsi ?? 'No Description'}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () async {
                String? pdfAssetPath = pdfEntity.assetPath;
                if (pdfAssetPath != null) {
                  try {
                    PDFDocument document =
                        await PDFDocument.fromAsset(pdfAssetPath);
                    Navigator.of(context).pop(); // Close the detail dialog
                    _showPdfViewer(document);
                  } catch (e) {
                    print('Error loading PDF: $e');
                    // Handle the error, e.g., show a Snackbar or navigate to an error screen.
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('PDF Asset Path is null.'),
                    ),
                  );
                }
              },
              child: Text('Download'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPdfViewer(PDFDocument document) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewer(document: document),
      ),
    );
  }

  Future<void> _downloadPdf(PdfEntity pdfEntity) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      String fileName = pdfEntity.judul ?? 'NoTitle';
      String filePath = '$appDocPath/$fileName.pdf';

      File file = File(filePath);
      await file.writeAsBytes(await pdfEntity.getPdfBytes());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('PDF downloaded successfully.'),
        ),
      );
    } catch (e) {
      print('Error downloading PDF: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading PDF.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Proposal dan LPJ'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                padding: MaterialStateProperty.all(EdgeInsets.all(16)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/program_kerja_images');
              },
              child: Text(
                'Dokumentasi Program Kerja',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: FutureBuilder<List<PdfEntity>>(
              future: pdfList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  List<PdfEntity> pdfListData = snapshot.data!;
                  return ListView.builder(
                    itemCount: pdfListData.length,
                    itemBuilder: (context, index) {
                      PdfEntity pdfEntity = pdfListData[index];
                      return Card(
                        elevation: 5,
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          color: Colors.lightBlue[50],
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text(
                              pdfEntity.judul ?? 'No Title',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Penulis: ${pdfEntity.penulis ?? 'No Author'}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color: Colors.teal,
                            ),
                            onTap: () {
                              _showPdfDetailDialog(pdfEntity);
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No PDFs available.'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
