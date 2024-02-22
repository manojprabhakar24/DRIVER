import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'g.dart';
import 'home.dart'; // Import FirebaseAuth for authentication status

class MyHomePage extends StatelessWidget {
  final VoidCallback onLogout;

  const MyHomePage({Key? key, required this.onLogout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check authentication status when the MyHomePage widget is built
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    if (user == null) {
      // If user is not authenticated, navigate to the login screen
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(onLogin: () {  },), // Your login screen
          ),
        );
      });

      // Return an empty container while navigating to login screen
      return Container();
    }

    // If user is authenticated, return the home page
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate back to login screen when logout button is pressed
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MainScreen(phoneNumber: '',), // Your login screen
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Home Page!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen(phoneNumber: '',)), // Your next screen
                );
              },
              child: Text('Next Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
