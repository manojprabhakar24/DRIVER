import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'otp.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryCode = TextEditingController();
  var phone = "";
  bool _isLoading = false;

  @override
  void initState() {
    countryCode.text = '+91';
    super.initState();
    //checkUserPhoneNumber();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
          backgroundColor: Color(0xffffded0),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image widget
              Image.asset(
                'assets/1.png',
                width: 200, // adjust the width as needed
                height: 100, // adjust the height as needed
              ),
              // Three Text widgets with different font sizes
              Text(
                'Welcome',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                '"Unlock Your Journey"',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Register Today',
                style: TextStyle(fontSize: 18),
              ),
              // SizedBox for additional spacing if needed
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.orange),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white38,
              ),
              child: Row(
                children: [
                  SizedBox(
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          controller: countryCode,
                        ),
                      )
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '|',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your number',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.orange,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'OR',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Navigate to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              child: Center(
                child: Text(
                  'Register A New Account?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  disabledBackgroundColor: Colors.white,
                  shadowColor: Colors.grey,
                ),
                onPressed: () async {
                  // Check if the name is empty

                    // If the name is not empty, proceed with phone verification
                    await APIs.auth.verifyPhoneNumber(
                      phoneNumber: '${countryCode.text + phone}',
                      verificationCompleted: (PhoneAuthCredential credential) async {
                        // Handle verification completed
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        // Handle verification failed
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        LoginScreen.verify = verificationId;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OTP(enteredName: '${countryCode.text + phone}'),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        // Handle code auto retrieval timeout
                      },
                      timeout: Duration(seconds: 60),
                    );
                  }, child: Text("Continue",style: TextStyle(
                color: Colors.white,fontSize: 20
              ),),



        ),

    ])));}
}


class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;


  static User get user => auth.currentUser!;

  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    //final time = DateTime.now().millisecondsSinceEpoch.toString();
  }

}