import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/features/presentation/routes/navigation_service.dart';
import 'package:flutter_firebase/features/presentation/widgets/app_navigation.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
        widget.navigationService.navigateToPage('/profile');
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

  void _showUpdateProfileDialog(BuildContext context) {
    TextEditingController displayNameController = TextEditingController();
    TextEditingController organizationController = TextEditingController();
    TextEditingController numberController = TextEditingController();

    // Initialize controllers with current values
    displayNameController.text = _userProfile?['displayName'] ?? '';
    organizationController.text = _userProfile?['organization'] ?? '';
    numberController.text = _userProfile?['number'] ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: displayNameController,
                  decoration: InputDecoration(labelText: 'Display Name'),
                ),
                TextFormField(
                  controller: organizationController,
                  decoration: InputDecoration(labelText: 'Organization'),
                ),
                TextFormField(
                  controller: numberController,
                  decoration: InputDecoration(labelText: 'Number'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Validate and update the user profile here
                String displayName = displayNameController.text;
                String organization = organizationController.text;
                String number = numberController.text;

                if (displayName.isNotEmpty &&
                    organization.isNotEmpty &&
                    number.isNotEmpty) {
                  // Update user profile
                  await _updateUserProfile(displayName, organization, number);
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Show an error message or handle validation
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill in all fields.'),
                    ),
                  );
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUserProfile(
      String displayName, String organization, String number) async {
    try {
      await FirestoreService().updateUserProfile(
        _user!.uid,
        displayName,
        _userProfile?['email'] ?? '',
        _userProfile?['imgUrl'] ?? '',
        organization,
        number,
      );

      // Reload the user profile after updating
      _loadUserProfile();
    } catch (e) {
      print('Error updating user profile: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
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
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showUpdateProfileDialog(context);
                        },
                        child: Text("Update Profile"),
                      ),
                    ],
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
