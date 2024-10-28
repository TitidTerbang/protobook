class AppUser {
  String name;
  String profilePicture;
  String? email;
  String? bio; // Tambah field bio

  AppUser({
    required this.name,
    required this.profilePicture,
    this.email,
    this.bio, // Tambah parameter bio
  });

  // Tambah method untuk convert ke Map (untuk Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePicture': profilePicture,
      'email': email,
      'bio': bio,
    };
  }

  // Tambah factory constructor dari Map (untuk Firestore)
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] ?? 'Nama User',
      profilePicture: map['profilePicture'] ?? 'https://via.placeholder.com/150',
      email: map['email'],
      bio: map['bio'],
    );
  }
}