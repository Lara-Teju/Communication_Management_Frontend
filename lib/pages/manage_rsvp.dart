import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InvitationScreen extends StatefulWidget {
  @override
  _InvitationScreenState createState() => _InvitationScreenState();
}

class _InvitationScreenState extends State<InvitationScreen> {
  List _events = [];
  String? _selectedEventId;
  bool _isLoading = false;

  final TextEditingController _memberIdController = TextEditingController();
  String _rsvpMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  // Fetch events from the backend
  Future<void> _fetchEvents() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/events'));
    if (response.statusCode == 200) {
      setState(() {
        _events = json.decode(response.body);
      });
    } else {
      print('Failed to load events');
    }
  }

  // Trigger sending invitations
  Future<void> _sendInvitations() async {
    if (_selectedEventId == null) return;

    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://localhost:3000/api/invitations'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'eventId': _selectedEventId}),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invitations Sent'),
          content: Text('Invitations have been sent successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print('Failed to send invitations');
    }
  }

  // Handle RSVP submission
  Future<void> _submitRsvp() async {
    if (_selectedEventId == null || _memberIdController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _rsvpMessage = '';
    });

    final response = await http.get(
      Uri.parse('http://localhost:3000/api/rsvp?eventId=$_selectedEventId&memberId=${_memberIdController.text}'),
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      setState(() {
        _rsvpMessage = 'RSVP successful!';
      });
    } else {
      setState(() {
        _rsvpMessage = 'Failed to RSVP.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Invitations & RSVP'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              hint: Text('Select an Event'),
              value: _selectedEventId,
              items: _events.map<DropdownMenuItem<String>>((event) {
                return DropdownMenuItem<String>(
                  value: event['_id'],
                  child: Text(event['title']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedEventId = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendInvitations,
              child: Text('Send Invitations'),
            ),
            SizedBox(height: 40),
            Divider(),
            Text(
              'RSVP Section',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _memberIdController,
              decoration: InputDecoration(
                labelText: 'Member ID',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitRsvp,
              child: Text('Submit RSVP'),
            ),
            SizedBox(height: 20),
            if (_rsvpMessage.isNotEmpty)
              Text(
                _rsvpMessage,
                style: TextStyle(color: _rsvpMessage.contains('successful') ? Colors.green : Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}

