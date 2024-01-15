import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/domain/usecases/pdf_usecase.dart';
import 'package:flutter_firebase/features/presentation/routes/navigation_service.dart';
import 'package:flutter_firebase/features/presentation/widgets/bottom_navigation.dart';
import 'package:flutter_firebase/features/presentation/widgets/pdf_list_screen.dart';
import 'package:flutter_firebase/features/presentation/widgets/pdf_upload_screen.dart';

class PdfPage extends StatefulWidget {
  final NavigationService navigationService;
  final PdfUseCase pdfUseCase;

  PdfPage({required this.navigationService, required this.pdfUseCase});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  int _currentIndex = 2;

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        widget.navigationService.navigateToPage('/home');
        break;
      case 1:
        widget.navigationService.navigateToPage('/room'); // Corrected path
        break;
      case 3:
        widget.navigationService.navigateToPage('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? PdfUploadScreen(pdfUseCase: widget.pdfUseCase)
          : PdfListScreen(pdfUseCase: widget.pdfUseCase),
      bottomNavigationBar: MyBottomNavigationBar(
        navigationService: widget.navigationService,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          navigateToPage(index);
        },
      ),
    );
  }
}
