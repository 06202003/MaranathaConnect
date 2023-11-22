import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_firebase/features/user_auth/presentation/widgets/app_navigation.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/room_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/widgets/bottom_navigation.dart';

import '../../../../global/common/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.navigationService}) : super(key: key);

  final NavigationService navigationService; // Uncomment this line

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late NavigationService navigationService;

  // _HomePageState(this.navigationService);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Welcome Home!"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: AppNavigation(), // Replace with your AppNavigation
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _buildPage(_currentIndex),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        navigationService: widget.navigationService,
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return CalendarWidget();
      case 1:
        return PinjamRuanganPage();
      // case 2:
      //   return ChatPage(); // Assuming you have a ChatPage widget
      // case 3:
      //   return ProfilePage(); // Assuming you have a ProfilePage widget
      default:
        return Container();
    }
  }
}

class DrawerMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const DrawerMenuItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
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
