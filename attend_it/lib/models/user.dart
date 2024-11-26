class User {
  final int id; 
  final String username; 
  final String email; 
  final String role; 
  final String? nim; 
  final String? namaMahasiswa; 
  final String? prodi; 
  final String? idKelas; 
  final String token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.nim,
    this.namaMahasiswa,
    this.prodi,
    this.idKelas,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], 
      username: json['username'], 
      email: json['email'], 
      role: json['role'],
      nim: json['nim'], 
      namaMahasiswa: json['namaMahasiswa'], 
      prodi: json['prodi'], 
      idKelas: json['idKelas'], 
      token: json['token']
    );
  }
}