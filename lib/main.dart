import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/data/datasources/pdf_datasources.dart';
import 'package:flutter_firebase/features/data/repositories/pdf_repository_impl.dart';
import 'package:flutter_firebase/features/domain/repositories/pdf_repository.dart';
import 'package:flutter_firebase/features/domain/usecases/pdf_usecase.dart';
import 'package:flutter_firebase/features/presentation/pages/pdf_page.dart';
import 'package:flutter_firebase/features/presentation/pages/profile_page.dart';
import 'package:flutter_firebase/features/presentation/themes/app_theme.dart';
import 'package:flutter_firebase/features/app/splash_screen/splash_screen.dart';
import 'package:flutter_firebase/features/presentation/pages/home_page.dart';
import 'package:flutter_firebase/features/presentation/pages/login_page.dart';
import 'package:flutter_firebase/features/presentation/pages/sign_up_page.dart';
import 'package:flutter_firebase/features/presentation/pages/room_page.dart';
import 'package:flutter_firebase/features/presentation/routes/navigation_service.dart';
import 'package:flutter_firebase/features/presentation/widgets/program_kerja_images.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyAqIxWjayz47yGsjgV9lHiMRd09a8I9XF0",
        appId: "1:1096057141526:web:99f6aa9df3dec2ede43837",
        messagingSenderId: "1096057141526",
        projectId: "maranathaconnect-b38df",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  final PdfDataSource pdfDataSource = PdfDataSource();
  final PdfRepository pdfRepository = PdfRepositoryImpl(pdfDataSource);
  final PdfUseCase pdfUseCase = PdfUseCase(pdfRepository);
  runApp(
    ProviderScope(
      child: MyApp(pdfUseCase: pdfUseCase),
    ),
  );
}

class MyApp extends StatelessWidget {
  final NavigationService _navigationService = NavigationService();
  final PdfUseCase pdfUseCase;

  MyApp({required this.pdfUseCase});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'MaranathaConnect',
      theme: appTheme,
      routes: {
        '/': (context) => SplashScreen(
              child: LoginPage(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(navigationService: _navigationService),
        '/room': (context) =>
            PinjamRuanganPage(navigationService: _navigationService),
        '/doc': (context) => PdfPage(
              navigationService: _navigationService,
              pdfUseCase: pdfUseCase,
            ),
        '/profile': (context) =>
            ProfilePage(navigationService: _navigationService),
        '/program_kerja_images': (context) => ProgramKerjaImagesPage(),
      },
    );
  }
}
