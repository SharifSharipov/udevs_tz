class TodoModel {
  final int id;
  final String eventName;
  final String eventDesc;
  final String eventLocation;
  final String priorityColor;
  final String eventTime;
  final String eventDate;

  const TodoModel({
    required this.eventDesc,
    required this.eventLocation,
    required this.eventName,
    required this.priorityColor,
    required this.eventTime,
    required this.id,
    required this.eventDate,
  });

  TodoModel copyWith({
    String? eventName,
    String? eventDesc,
    String? eventLocation,
    String? priorityColor,
    String? eventTime,
    String? eventDate,
    int? id,
  }) {
    return TodoModel(
      eventName: eventName ?? this.eventName,
      eventDesc: eventDesc ?? this.eventDesc,
      eventLocation: eventLocation ?? this.eventLocation,
      priorityColor: priorityColor ?? this.priorityColor,
      eventTime: eventTime ?? this.eventTime,
      id: id ?? this.id,
      eventDate: eventDate ?? this.eventDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event_name': eventName,
      'event_desc': eventDesc,
      'event_location': eventLocation,
      'priority_color': priorityColor,
      'event_time': eventTime,
      'event_date': eventDate,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        eventDesc: json['event_desc'] ?? '',
        eventLocation: json['event_location'] ?? '',
        eventName: json['event_name'] ?? '',
        priorityColor: json['priority_color'] ?? '0xFFFFFFFF',
        eventTime: json['event_time'] ?? '',
        id: json['_id'] ?? 0,
        eventDate: json['event_date'] ?? '',
      );

  @override
  String toString() =>
      'eventName: $eventName, eventDesc: $eventDesc, eventLocation: $eventLocation, eventTime: $eventTime, priorityColor: $priorityColor, eventDate: $eventDate';
}
