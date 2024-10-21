import 'package:flutter/material.dart';
import '../pages/create_event.dart';
import '../pages/manage_rsvp.dart';
import '../pages/billing.dart';
import '../pages/feedback.dart';
import '../pages/reports.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text('Communication Module'),
          ),
          ListTile(
            title: Text('Create Event'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateEventPage()),
              );
            },
          ),
          ListTile(
            title: Text('Manage Invitations/RSVP'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InvitationScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Generate Billing'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BillingPlaceholderPage()),
              );
            },
          ),
          ListTile(
            title: Text('Analyze Feedback'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackPlaceholderPage()),
              );
            },
          ),
          ListTile(
            title: Text('Reports'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportsPlaceholderPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
