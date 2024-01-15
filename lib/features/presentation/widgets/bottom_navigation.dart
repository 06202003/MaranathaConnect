import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/presentation/routes/navigation_service.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final NavigationService navigationService;
  final int currentIndex; // New property to hold the current index
  final ValueChanged<int> onTap; // Callback when an item is tapped

  MyBottomNavigationBar({
    required this.navigationService,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

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
          label: 'Room',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_copy),
          label: 'Doc',
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
          widget.onTap(index);
        });
        _navigateToPage(index); // Call the method in the state class
      },
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        widget.navigationService.navigateToPage('/home');
        break;
      case 1:
        widget.navigationService.navigateToPage('/room');
        break;
      case 2:
        widget.navigationService.navigateToPage('/doc');
        break;
      case 3:
        widget.navigationService.navigateToPage('/profile');
        break;
    }
  }
}
