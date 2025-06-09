class ProfileModel {

  final String uid;
  final String name;
  final String email;
  final String bio;
  final List<String> skills;
  final List<String> wishes;
  final int lastEditedTime;

  ProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.bio,
    required this.skills,
    required this.wishes,
    required this.lastEditedTime,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      bio: map['bio'] ?? '',
      skills: List<String>.from(map['skills'] ?? []),
      wishes: List<String>.from(map['wishes'] ?? []),
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
      'wishes': wishes,
      'lastEditedTime': lastEditedTime,
    };
  }

}
