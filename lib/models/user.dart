class AppUser {
  String name;
  String profilePicture;
  String? email;
  String? bio;

  AppUser({
    required this.name,
    required this.profilePicture,
    this.email,
    this.bio,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePicture': profilePicture,
      'email': email,
      'bio': bio,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] ?? 'Nama User',
      profilePicture: map['profilePicture'] ?? 'https://via.placeholder.com/150',
      email: map['email'],
      bio: map['bio'],
    );
  }
}
