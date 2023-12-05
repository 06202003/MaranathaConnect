import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/service/firebase_auth_implementation/firebase_auth_services.dart';

// import 'package:flutter_firebase/features/presentation/pages/home_page.dart';
// import 'package:flutter_firebase/features/presentation/pages/room_page.dart';
// import 'package:flutter_firebase/features/presentation/pages/chat_page.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({Key? key}) : super(key: key);

  @override
  _AppNavigationState createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  final FirebaseAuthService authService = FirebaseAuthService();

  Future<void> handleSignOut() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            shrinkWrap: true,
            children: [
              NavigationTile(
                icon: Icons.home,
                label: 'Home',
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/home'));
                },
                iconColor: Colors.black,
              ),
              NavigationTile(
                icon: Icons.chat,
                label: 'Chat',
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/chat'));
                },
                iconColor: Colors.black,
              ),
              NavigationTile(
                icon: Icons.room,
                label: 'Room',
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/room'));
                },
                iconColor: Colors.black,
              ),
              NavigationTile(
                icon: Icons.person,
                label: 'Profile',
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/profile'));
                },
                iconColor: Colors.black,
              ),
            ],
          ),
          SizedBox(height: 40.0),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                padding: MaterialStateProperty.all(EdgeInsets.all(16)),
              ),
              onPressed: () async {
                await handleSignOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Logout Button
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
        decoration: BoxDecoration(
          color: Colors.blue, // Background color
          borderRadius: BorderRadius.circular(16), // Border radius
        ),
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(4, 27, 0, 25),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          leading: Container(
            width: 30, 
             padding: EdgeInsets.fromLTRB(4, 2, 0, 2),
            child: Center(
              child: Icon(
                icon,
                color: iconColor, // Set the icon color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
