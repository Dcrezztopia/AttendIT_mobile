class Schedule {
  final String time;
  final String course;
  final String lecturer;
  final String room;

  Schedule({
    required this.time,
    required this.course,
    required this.lecturer,
    required this.room,
  });

  // Method untuk parsing dari JSON (sesuaikan jika menggunakan database berbeda)
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      time: json['time'],
      course: json['course'],
      lecturer: json['lecturer'],
      room: json['room'],
    );
  }
}

