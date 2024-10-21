//dashboard.dart
import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/event_calendar.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const EventCalendar(), // No need to pass events here, EventCalendar will fetch them
    );
  }
}
