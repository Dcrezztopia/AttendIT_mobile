class Schedule {
  final int id;
  final String day;
  final String timeStart;
  final String timeEnd;
  final String room;
  final String namaDosen;
  final String namaMatkul;
  final String status;

  Schedule({
    required this.id,
    required this.day,
    required this.timeStart,
    required this.timeEnd,
    required this.room,
    required this.namaDosen,
    required this.namaMatkul,
    required this.status,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      day: json['hari'],
      timeStart: json['waktu_mulai'],
      timeEnd: json['waktu_selesai'],
      room: json['ruang_kelas'],
      namaDosen: json['nama_dosen'],
      namaMatkul: json['nama_matkul'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() { 
    return { 
      'id': id, 
      'hari': day, 
      'waktu_mulai': timeStart, 
      'waktu_selesai': timeEnd, 
      'ruang_kelas': room, 
      'status': status, 
      'nama_dosen': namaDosen, 
      'nama_matkul': namaMatkul, }; }
}
