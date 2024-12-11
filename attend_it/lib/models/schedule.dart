class Schedule {
  final int id;
  final String hari;
  final String waktuMulai;
  final String waktuSelesai;
  final String ruangKelas;
  final String status;
  final String namaDosen;
  final String namaMatkul;
  // final bool isActive;

  Schedule({
    required this.id,
    required this.hari,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.ruangKelas,
    required this.status,
    required this.namaDosen,
    required this.namaMatkul,
    // required this.isActive,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      hari: json['hari'],
      waktuMulai: json['waktu_mulai'],
      waktuSelesai: json['waktu_selesai'],
      ruangKelas: json['ruang_kelas'],
      status: json['status'],
      namaDosen: json['nama_dosen'],
      namaMatkul: json['nama_matkul'],
      // isActive: json['status'] == "1", // Ubah status ke boolean
    );
  }
}
