import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/features/presentation/routes/navigation_service.dart';
import 'package:flutter_firebase/features/presentation/widgets/bottom_navigation.dart';
import 'package:flutter_firebase/features/service/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter_firebase/features/service/firestore_service/firestore_auth_service.dart';

class ProfilePage extends StatefulWidget {
  final NavigationService navigationService;

  ProfilePage({required this.navigationService});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  User? _user;
  Map<String, dynamic>? _userProfile;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    FirebaseAuthService authService = FirebaseAuthService();
    FirestoreService firestoreService = FirestoreService();

    _user = await authService.getCurrentUser();

    if (_user != null) {
      _userProfile = await firestoreService.getUserProfile(_user!.uid);

      // If the user profile is not available, you can redirect to a profile setup page.
      if (_userProfile == null) {
        // Navigate to profile setup page.
        // Example: widget.navigationService.navigateToPage('/profile_setup');
      }

      setState(() {});
    }
  }

  void navigateToPage(int index) {
    switch (index) {
      case 0:
        widget.navigationService.navigateToPage('/home');
        break;
      case 1:
        widget.navigationService.navigateToPage('/room');
        break;
      case 2:
        widget.navigationService.navigateToPage('/chat');
        break;
      case 3:
        // This is the current page, you might not need to navigate anywhere.
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _userProfile != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(
                        _userProfile?['imgUrl'] ?? '',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Display Name:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    _userProfile?['displayName'] ?? '',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    _userProfile?['email'] ?? '',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Organization:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    _userProfile?['organization'] ?? '',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Number:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    _userProfile?['number'] ?? '',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
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
