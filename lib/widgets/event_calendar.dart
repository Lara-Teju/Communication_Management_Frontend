//event_calendar.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/event_model.dart';
import '../widgets/event_service.dart';
import '../pages/event_detail.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({Key? key}) : super(key: key);

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  late Map<DateTime, List<EventModel>> _eventsMap = {};
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  List<EventModel> _selectedEvents = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAndSetEvents();
  }

  // Fetch events from backend
  void _fetchAndSetEvents() async {
    try {
      List<EventModel> events = await EventService().fetchEvents();
      print("Fetched events: $events");  // Add this to see the fetched events
      setState(() {
        _eventsMap = _groupEventsByDate(events);
        _selectedEvents = _getEventsForDay(_selectedDay);
        print("Events for selected day $_selectedDay: $_selectedEvents");  // Add this
        _isLoading = false;
      });
    } catch (error) {
      print("Error fetching events: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }


  Map<DateTime, List<EventModel>> _groupEventsByDate(List<EventModel> events) {
    Map<DateTime, List<EventModel>> eventsMap = {};

    for (var event in events) {
      if (event.date != null) {
        final eventDate = DateTime.parse(event.date!).toLocal();  // Parse the date string
        final normalizedDate = DateTime(eventDate.year, eventDate.month, eventDate.day);
        if (eventsMap[normalizedDate] == null) {
          eventsMap[normalizedDate] = [];
        }
        eventsMap[normalizedDate]!.add(event);
      }
    }

    print("Grouped Events Map: $eventsMap");  // Add this to verify events mapping
    return eventsMap;
  }


  List<EventModel> _getEventsForDay(DateTime day) {
    return _eventsMap[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
      children: [
        TableCalendar<EventModel>(
          firstDay: DateTime(2000),
          lastDay: DateTime(2100),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            final normalizedSelectedDay = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);  // Normalize selected day
            print("Selected day (normalized): $normalizedSelectedDay");

            setState(() {
              _selectedDay = normalizedSelectedDay;
              _focusedDay = focusedDay;
              _selectedEvents = _getEventsForDay(normalizedSelectedDay);  // Fetch the events for the normalized date
              print("Events for selected day: $_selectedEvents");
            });
          }
,

          eventLoader: (day) => _getEventsForDay(day),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            todayDecoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: _selectedEvents.isEmpty
              ? const Center(child: Text("No events for selected day."))
              : ListView.builder(
            itemCount: _selectedEvents.length,
            itemBuilder: (context, index) {
              final event = _selectedEvents[index];
              return ListTile(
                title: Text(event.title ?? 'Untitled Event'),
                subtitle: Text(event.description ?? 'No description available'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailPage(event: event),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}


