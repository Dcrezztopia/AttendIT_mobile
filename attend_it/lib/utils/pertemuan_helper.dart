class PertemuanHelper {
  static final Map<String, List<String>> jadwalPertemuan = {
    'pertemuan_1' : ['2024-08-26', '2024-08-27', '2024-08-28', '2024-08-29', '2024-08-30'],
    'pertemuan_2' : ['2024-09-02', '2024-09-03', '2024-09-04', '2024-09-05', '2024-09-06'],
    'pertemuan_3' : ['2024-09-09', '2024-09-10', '2024-09-11', '2024-09-12', '2024-09-13'],
    'pertemuan_4' : ['2024-09-16', '2024-09-17', '2024-09-18', '2024-09-19', '2024-09-20'],
    'pertemuan_5' : ['2024-09-23', '2024-09-24', '2024-09-25', '2024-09-26', '2024-09-27'],
    'pertemuan_6' : ['2024-09-30', '2024-10-01', '2024-10-02', '2024-10-03', '2024-10-04'],
    'pertemuan_7' : ['2024-10-07', '2024-10-08', '2024-10-09', '2024-10-10', '2024-10-11'],
    'pertemuan_8' : ['2024-10-14', '2024-10-15', '2024-10-16', '2024-10-17', '2024-10-18'],
    'pertemuan_9' : ['2024-10-21', '2024-10-22', '2024-10-23', '2024-10-24', '2024-10-25'],
    'pertemuan_10' : ['2024-10-28', '2024-10-29', '2024-10-30', '2024-10-31', '2024-11-01'],
    'pertemuan_11' : ['2024-11-04', '2024-11-05', '2024-11-06', '2024-11-07', '2024-11-08'],
    'pertemuan_12' : ['2024-11-11', '2024-11-12', '2024-11-13', '2024-11-14', '2024-11-15'],
    'pertemuan_13' : ['2024-11-18', '2024-11-19', '2024-11-20', '2024-11-21', '2024-11-22'],
    'pertemuan_14' : ['2024-11-25', '2024-11-26', '2024-11-27', '2024-11-28', '2024-11-29'],
    'pertemuan_15' : ['2024-12-02', '2024-12-03', '2024-12-04', '2024-12-05', '2024-12-06'],
    'pertemuan_16' : ['2024-12-09', '2024-12-10', '2024-12-11', '2024-12-12', '2024-12-13'],
    'pertemuan_17' : ['2024-12-16', '2024-12-17', '2024-12-18', '2024-12-19', '2024-12-20'],
  };

  static int getPertemuanKe(String tanggal) {
    for (var entry in jadwalPertemuan.entries) {
      if (entry.value.contains(tanggal)) {
        return int.parse(entry.key.split('_')[1]);
      }
    }
    return 0; // Return 0 jika tidak ditemukan
  }
} 