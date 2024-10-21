//main.dart
import 'package:flutter/material.dart';
import 'pages/dashboard.dart';

void main() {
  runApp(CommunicationModuleApp());
}

class CommunicationModuleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Communication Module',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardPage(),
    );
  }
}

