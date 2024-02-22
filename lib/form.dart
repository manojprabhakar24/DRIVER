import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'g.dart';

class NewScreen extends StatefulWidget {
  final String phoneNumber; // Add phoneNumber field
  const NewScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  late String lastFourDigits;

  final TextEditingController driverNameController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Extract the last four digits of the phone number
    lastFourDigits = widget.phoneNumber.substring(widget.phoneNumber.length - 4);
    // Pre-fill the driver name field with the last four digits of the received phone number
    driverNameController.text = '********' + lastFourDigits; // Hiding the first digits
  }

  Future<void> _storeDataInFirebase() async {
    try {
      String driverName = widget.phoneNumber; // Storing full phone number
      String licenseNumber = licenseNumberController.text;
      String vehicleNumber = vehicleNumberController.text;

      // Store data in Firestore
      await FirebaseFirestore.instance.collection('drivers').add({
        'phoneNumber': widget.phoneNumber,
        'driverName': driverName,
        'licenseNumber': licenseNumber,
        'vehicleNumber': vehicleNumber,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Data stored successfully in Firestore');
    } catch (e) {
      print('Error storing data in Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Fill in the Driver Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: driverNameController,
              decoration: InputDecoration(
                labelText: 'Phone Number', // Change label text to Phone Number
                border: OutlineInputBorder(),
              ),
              readOnly: true, // Make it read-only if you don't want users to edit it
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: licenseNumberController,
              decoration: InputDecoration(
                labelText: 'License Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: vehicleNumberController,
              decoration: InputDecoration(
                labelText: 'Vehicle Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _storeDataInFirebase();
                // Navigate to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MainScreen(phoneNumber: widget.phoneNumber),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
