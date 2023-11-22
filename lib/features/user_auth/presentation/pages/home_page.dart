import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("HomePage"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Welcome Home!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/login");
              showToast(message: "Successfully signed out");
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Sign out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Pindah ke halaman "movie_page"
              Navigator.pushNamed(context, "/movie_page");
            },
            child: Container(
              height: 45,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.green, // Ganti warna sesuai preferensi Anda
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Movies",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
              height:
                  20), // Tambahkan jarak antara tombol Sign Out dan CalendarWidget
          Expanded(
            child:
                CalendarWidget(), // Tampilkan CalendarWidget di bawah tombol Sign Out
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {}; // Menyimpan daftar tugas

  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime(2023, 1, 1),
          lastDay: DateTime(2023, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          eventLoader: (day) => _getEventsForDay(day),
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(labelText: 'Tambah Tugas'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  String task = _taskController.text;
                  if (task.isNotEmpty) {
                    setState(() {
                      if (_events[_focusedDay] == null) {
                        _events[_focusedDay] = [task];
                      } else {
                        _events[_focusedDay]!.add(task);
                      }
                    });
                    _taskController.clear();
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _events[_focusedDay]?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_events[_focusedDay]![index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _events[_focusedDay]?.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<String> _getEventsForDay(DateTime day) {
    if (_events.containsKey(day)) {
      return _events[day] ?? [];
    } else {
      return [];
    }
  }
}
