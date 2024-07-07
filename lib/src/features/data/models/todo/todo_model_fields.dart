class TodoModelSQL {
  //DATABASE
  static const tableName = 'todoTable';
  static const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const intType = 'INTEGER DEFAULT 0';
  static const textType = 'TEXT NOT NULL';
  static const id = '_id';
  static const eventName = 'event_name';
  static const eventDesc = 'event_desc';
  static const eventLocation = 'event_location';
  static const priorityColor = 'priority_color';
  static const eventTime = 'event_time';
  static const eventDate = 'event_date';
}
