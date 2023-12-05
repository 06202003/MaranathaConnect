import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/presentation/widgets/app_navigation.dart';
import 'package:flutter_firebase/features/presentation/widgets/bottom_navigation.dart';
import 'package:flutter_firebase/features/presentation/routes/navigation_service.dart';

class PinjamRuanganPage extends StatefulWidget {
  final NavigationService navigationService;

  PinjamRuanganPage({Key? key, required this.navigationService})
      : super(key: key);

  @override
  _PinjamRuanganPageState createState() => _PinjamRuanganPageState();
}

class _PinjamRuanganPageState extends State<PinjamRuanganPage> {
  void navigateToPage(int index) {
    switch (index) {
      case 0:
        widget.navigationService.navigateToPage('/home');
        break;
      case 1:
        // This is the current page, you might not need to navigate anywhere.
        break;
      case 2:
        widget.navigationService.navigateToPage('/chat');
        break;
      case 3:
        widget.navigationService.navigateToPage('/profile');
        break;
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Room Reservation"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: AppNavigation(),
      ),
      body: Center(
        child: Text('Ini Halaman Pinjam Ruangan'),
      ),
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

class DrawerMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const DrawerMenuItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}
