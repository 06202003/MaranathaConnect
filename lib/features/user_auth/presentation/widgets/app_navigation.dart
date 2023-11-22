import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/room_page.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        shrinkWrap: true,
        children: [
          NavigationTile(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/home'));
            },
            iconColor: Colors.black, // Set the desired icon color
          ),
          NavigationTile(
            icon: Icons.chat,
            label: 'Chat',
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/chat'));
            },
            iconColor: Colors.black, // Set the desired icon color
          ),
          NavigationTile(
            icon: Icons.room,
            label: 'Room',
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => PinjamRuanganPage()),
                (route) => false,
              );
            },
            iconColor: Colors.black, // Set the desired icon color
          ),
          NavigationTile(
            icon: Icons.person,
            label: 'Profile',
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/profile'));
            },
            iconColor: Colors.black, // Set the desired icon color
          ),
        ],
      ),
    );
  }
}

class NavigationTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor; // Change color to iconColor

  const NavigationTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.iconColor, // Change color to iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.blue, // Background color
        child: ListTile(
          title: Text(
            label,
            style: TextStyle(
              color: Colors.black, // Text color
            ),
          ),
          leading: Icon(
            icon,
            color: iconColor, // Set the icon color
          ),
        ),
      ),
    );
  }
}
