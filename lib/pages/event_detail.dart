//event_detail.dart
import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  const EventDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title ?? 'Event Details'), // Provide default value
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${event.title ?? 'Untitled Event'}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Date: ${event.date ?? 'No date specified'}'),
            const SizedBox(height: 8),
            Text('Time: ${event.time ?? 'No time specified'}'),
            const SizedBox(height: 8),
            Text('Location: ${event.location ?? 'No location specified'}'),
            const SizedBox(height: 8),
            Text('Description: ${event.description ?? 'No description available'}'),
            const SizedBox(height: 8),
            Text('Category: ${event.category ?? 'No category'}'),
            const SizedBox(height: 8),
            Text('Attendees: ${event.attendees?.join(', ') ?? 'No attendees'}'),
          ],
        ),
      ),
    );
  }
}
