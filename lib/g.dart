import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'new.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;

  @override
  void initState() {
    super.initState();
    // Check if user is already signed in when the app starts
    _user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return _user == null
        ? Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginScreen(
        onLogin: () {
          // Update user state when login is successful
          setState(() {
            _user = _auth.currentUser;
          });
        },
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle logout
                _auth.signOut().then((value) {
                  setState(() {
                    _user = null;
                  });
                });
              },
              child: Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}
