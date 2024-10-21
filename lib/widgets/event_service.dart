//event_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/event_model.dart';

class EventService {
  final String baseUrl = 'http://localhost:3000'; // Replace with your backend URL

  Future<List<EventModel>> fetchEvents() async {
    final response = await http.get(Uri.parse('$baseUrl/api/events'));

    if (response.statusCode == 200) {
      List<dynamic> eventList = jsonDecode(response.body);
      return eventList.map((event) => EventModel.fromJson(event)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }
}


