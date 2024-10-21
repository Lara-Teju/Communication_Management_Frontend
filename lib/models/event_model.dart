class EventModel {
  String? title;
  String? date;
  String? time;
  String? location;
  String? description;
  String? category;
  List<String>? attendees;

  EventModel({
    this.title,
    this.date,
    this.time,
    this.location,
    this.description,
    this.category,
    this.attendees,
  });

  // Factory constructor to create EventModel from JSON
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      title: json['title'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      location: json['location'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      attendees: json['attendees'] != null
          ? List<String>.from(json['attendees'])
          : [], // Default to empty list if null
    );
  }

  // Convert EventModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'description': description,
      'category': category,
      'attendees': attendees,
    };
  }

  // Override toString method for better debugging
  @override
  String toString() {
    return '''
EventModel(
  title: $title, 
  date: $date, 
  time: $time, 
  location: $location, 
  description: $description, 
  category: $category, 
  attendees: ${attendees?.join(', ') ?? 'None'}
)
    ''';
  }
}



