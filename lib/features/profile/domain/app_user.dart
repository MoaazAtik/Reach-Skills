class AppUser {

  final String uid;
  final String name;
  final String email;
  final String bio;
  final List<String> skills;
  final int lastEditedTime;

  AppUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.bio,
    required this.skills,
    required this.lastEditedTime,
  });

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      skills: List<String>.from(map['skills'] ?? []),
      lastEditedTime: map['lastEditedTime'].toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'bio': bio,
      'skills': skills,
      'lastEditedTime': lastEditedTime,
    };
  }

}
