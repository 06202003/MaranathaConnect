import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/data/datasources/ruangan_remote_datasource.dart';
import 'package:flutter_firebase/features/data/models/ruangan_model.dart';

class ReservationForm extends StatefulWidget {
  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _ruanganController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Dummy data source
  final RuanganDatasource _ruanganDatasource = RuanganDatasource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<RuanganModel>>(
                future: _ruanganDatasource.getRuanganData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Display a dropdown with room names from the data source
                    List<RuanganModel> ruanganData = snapshot.data!;
                    return DropdownButtonFormField<RuanganModel>(
                      value: ruanganData.isNotEmpty ? ruanganData[0] : null,
                      onChanged: (RuanganModel? selectedRuangan) {
                        setState(() {
                          _ruanganController.text = selectedRuangan?.nama ?? '';
                        });
                      },
                      items: ruanganData.map((ruangan) {
                        return DropdownMenuItem<RuanganModel>(
                          value: ruangan,
                          child: Text(ruangan.nama),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Nama Ruangan'),
                      validator: (value) {
                        if (value == null) {
                          return 'Nama Ruangan is required';
                        }
                        return null;
                      },
                    );
                  }
                },
              ),
              SizedBox(height: 16),
              Text('Tanggal Peminjaman:'),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (pickedDate != null && pickedDate != _selectedDate) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  Text(
                    "${_selectedDate.toLocal().day}/${_selectedDate.toLocal().month}/${_selectedDate.toLocal().year}",
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Waktu Peminjaman:'),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (pickedTime != null && pickedTime != _selectedTime) {
                        setState(() {
                          _selectedTime = pickedTime;
                        });
                      }
                    },
                  ),
                  Text("${_selectedTime.format(context)}"),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Add logic to submit reservation
                    // You may want to use the values from _ruanganController, _selectedDate, and _selectedTime
                    // For example: String ruanganName = _ruanganController.text;
                    // DateTime reservationDateTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
                    // Then you can proceed with your logic
                    // After submitting, you may want to navigate back or show a success message
                  }
                },
                child: Text(
                  'Submit Reservation',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
