import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  final TextEditingController driverNameController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController vehicleNumberController = TextEditingController();

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
                labelText: 'Driver Name',
                border: OutlineInputBorder(),
              ),
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
                // Perform actions with the entered driver details
                String driverName = driverNameController.text;
                String licenseNumber = licenseNumberController.text;
                String vehicleNumber = vehicleNumberController.text;

                // You can handle the data as needed, for example, save it to a database.
                // For now, let's print it.
                print('Driver Name: $driverName');
                print('License Number: $licenseNumber');
                print('Vehicle Number: $vehicleNumber');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
