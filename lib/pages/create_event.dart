//create_event.dart
import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  DateTime? date;
  TimeOfDay? time;
  String location = '';
  String description = '';
  String category = '';
  String attendees = '';

  // Function to submit event data
  void _submitEvent() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      EventModel event = EventModel(
        title: title,
        date: date?.toIso8601String() ?? '',
        time: time?.format(context) ?? '',
        location: location,
        description: description,
        category: category,
        attendees: [],  // Set empty attendees on creation
      );

      var response = await http.post(
        Uri.parse('http://localhost:3000/api/events'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(event.toJson()),
      );

      if (response.statusCode == 201) {
        // Event created successfully
        Navigator.pop(context);
      } else {
        // Handle errorMeeting
        print('Failed to create event');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Event Title'),
              validator: (value) => value?.isEmpty ?? true ? 'Please enter event title' : null,
              onSaved: (value) => title = value ?? '',
            ),
            ListTile(
              title: Text('Event Date: ${date != null ? date!.toLocal().toString().split(' ')[0] : ''}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: date ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  setState(() {
                    date = picked;
                  });
                }
              },
            ),
            ListTile(
              title: Text('Event Time: ${time != null ? time!.format(context) : ''}'),
              trailing: Icon(Icons.access_time),
              onTap: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    time = picked;
                  });
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Location'),
              validator: (value) => value?.isEmpty ?? true ? 'Please enter location' : null,
              onSaved: (value) => location = value ?? '',
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              onSaved: (value) => description = value ?? '',
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Category'),
              items: ['Dinner', 'Meeting', 'Workshop']
                  .map((cat) => DropdownMenuItem(
                value: cat.toLowerCase(),
                child: Text(cat),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  category = value ?? '';
                });
              },
            ),
            ElevatedButton(
              onPressed: _submitEvent,
              child: Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
