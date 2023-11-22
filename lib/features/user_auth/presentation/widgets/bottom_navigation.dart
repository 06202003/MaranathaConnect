import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateToPage(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  final NavigationService navigationService;

  MyBottomNavigationBar({required this.navigationService});

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.room),
          label: 'Ruangan',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        _navigateToPage(index);
      },
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        widget.navigationService.navigateToPage('/home');
        break;
      case 1:
        widget.navigationService.navigateToPage('/ruangan');
        break;
      case 2:
        widget.navigationService.navigateToPage('/chat');
        break;
      case 3:
        widget.navigationService.navigateToPage('/profile');
        break;
    }
  }
}
