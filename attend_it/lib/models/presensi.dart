class Presensi {
  final int id;
  final int pertemuanKe;
  final String tanggalPresensi;
  final String statusPresensi;
  final String tahunAjaran;
  final Jadwal jadwal;

  Presensi({
    required this.id,
    required this.pertemuanKe,
    required this.tanggalPresensi,
    required this.statusPresensi,
    required this.tahunAjaran,
    required this.jadwal,
  });

  factory Presensi.fromJson(Map<String, dynamic> json) {
    return Presensi(
      id: json['id'],
      pertemuanKe: json['pertemuan_ke'],
      tanggalPresensi: json['tanggal_presensi'],
      statusPresensi: json['status_presensi'],
      tahunAjaran: json['tahun_ajaran'],
      jadwal: Jadwal.fromJson(json['jadwal']),
    );
  }
}

class Jadwal {
  final String hari;
  final String waktuMulai;
  final String waktuSelesai;
  final String ruangKelas;
  final String namaDosen;
  final String namaMatkul;

  Jadwal({
    required this.hari,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.ruangKelas,
    required this.namaDosen,
    required this.namaMatkul,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      hari: json['hari'],
      waktuMulai: json['waktu_mulai'],
      waktuSelesai: json['waktu_selesai'],
      ruangKelas: json['ruang_kelas'],
      namaDosen: json['nama_dosen'],
      namaMatkul: json['nama_matkul'],
    );
  }
} 