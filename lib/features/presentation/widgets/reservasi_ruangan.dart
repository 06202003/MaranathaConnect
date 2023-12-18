import 'package:flutter/material.dart';

class ReservationForm extends StatefulWidget {
  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  // Add form logic and controllers as needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add form fields and UI components
            Text('Nama Ruangan:'),
            TextFormField(
                // Add your text form field properties
                ),
            Text('Tanggal Peminjaman:'),
            // Add date picker or date input field
            ElevatedButton(
              onPressed: () {
                // Add logic to submit reservation
                // You may want to navigate back or show a success message
              },
              child: Text('Submit Reservation'),
            ),
          ],
        ),
      ),
    );
  }
}
