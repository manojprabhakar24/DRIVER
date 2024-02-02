import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'form.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController countryCode = TextEditingController();
  var phone = "";
  bool _isLoading = false;
  int selectedSegment = 0; // Variable to track the selected segment

  @override
  void initState() {
    countryCode.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
          backgroundColor: Color(0xffffded0),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/1.png',
                width: 200,
                height: 100,
              ),
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
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSegment = 0;
                      });
                    },
                    child: buildSegment(
                        height: 9,
                        color:
                            selectedSegment == 0 ? Colors.orange : Colors.grey),
                  ),
                ),
                SizedBox(width: 8), // Add a gap
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSegment = 1;
                      });
                    },
                    child: buildSegment(
                        height: 9,
                        color:
                            selectedSegment == 1 ? Colors.orange : Colors.grey),
                  ),
                ),
                SizedBox(width: 8), // Add a gap
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSegment = 2;
                      });
                    },
                    child: buildSegment(
                        height: 9,
                        color:
                            selectedSegment == 2 ? Colors.orange : Colors.grey),
                  ),
                ),
                SizedBox(width: 8), // Add a gap
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSegment = 3;
                      });
                    },
                    child: buildSegment(
                        height: 9,
                        color:
                            selectedSegment == 3 ? Colors.orange : Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registration',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Container(
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
                          ),
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
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                          ),
                          onPressed: () async {
                            // Trigger OTP sending process only if OTP hasn't been sent before
                            if (Register.verify.isEmpty) {
                              await APIs.auth.verifyPhoneNumber(
                                phoneNumber: '${countryCode.text + phone}',
                                verificationCompleted:
                                    (PhoneAuthCredential credential) async {},
                                verificationFailed:
                                    (FirebaseAuthException e) {},
                                codeSent:
                                    (String verificationId, int? resendToken) {
                                  Register.verify = verificationId;
                                  // Optionally, you can display a message to indicate that OTP has been sent.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'OTP has been sent to ${countryCode.text + phone}'),
                                    ),
                                  );
                                },
                                codeAutoRetrievalTimeout:
                                    (String verificationId) {},
                                timeout: Duration(seconds: 60),
                              );
                            }
                          },
                          child: Text(
                            'Get OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'OTP',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              controller: _otpController,
              onChanged: (value) {
                // Additional handling if needed
              },
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                disabledBackgroundColor: Colors.white,
                shadowColor: Colors.grey,
              ),
              onPressed: () async {
                _verifyOTP(_otpController.text);

                await APIs.auth.verifyPhoneNumber(
                  phoneNumber: '${countryCode.text + phone}',
                  verificationCompleted:
                      (PhoneAuthCredential credential) async {},
                  verificationFailed: (FirebaseAuthException e) {},
                  codeSent: (String verificationId, int? resendToken) {
                    Register.verify = verificationId;
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                  timeout: Duration(seconds: 60),
                );
              },
              child: Text(
                "Continue",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSegment({double height = 6, Color color = Colors.grey}) {
    return Container(
      height: height,
      color: color,
    );
  }

  void _verifyOTP(String enteredOTP) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: Register.verify,
        smsCode: enteredOTP,
      );

      await APIs.auth.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => NewScreen(),
        ),
      );
    } catch (e) {
      print("Error verifying OTP: $e");

      // Handle OTP verification failure
      // You can display an error message or take other actions
    }
  }
}

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static User get user => auth.currentUser!;

  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  static Future<void> createUser() async {
    // Handle user creation logic
  }
}
