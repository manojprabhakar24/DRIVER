import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final String phoneNumber;

  const MainScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Phone Number:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              phoneNumber,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
