import 'package:collection/collection.dart';
import 'package:reach_skills/features/common/data/skill_model.dart';
import 'package:reach_skills/features/common/data/wish_model.dart';

import '../../../core/constants/strings.dart';

class ProfileModel {
  final String uid;
  final String name;
  final String email;
  final String bio;
  final List<SkillModel> skills;
  final List<WishModel> wishes;
  final int lastEditedTime;

  ProfileModel({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.bio = '',
    this.skills = const <SkillModel>[],
    this.wishes = const <WishModel>[],
    this.lastEditedTime = 0,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      uid: map[Str.PROFILE_FIELD_UID],
      name: map[Str.PROFILE_FIELD_NAME],
      email: map[Str.PROFILE_FIELD_EMAIL],
      bio: map[Str.PROFILE_FIELD_BIO],
      skills: List<SkillModel>.from(
        map[Str.PROFILE_FIELD_SKILLS].map((skill) => SkillModel.fromMap(skill)),
      ),
      wishes: List<WishModel>.from(
        map[Str.PROFILE_FIELD_WISHES].map((wish) => WishModel.fromMap(wish)),
      ),
      lastEditedTime: map[Str.PROFILE_FIELD_LAST_EDITED_TIME],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Str.PROFILE_FIELD_UID: uid,
      Str.PROFILE_FIELD_NAME: name,
      Str.PROFILE_FIELD_EMAIL: email,
      Str.PROFILE_FIELD_BIO: bio,
      Str.PROFILE_FIELD_SKILLS: skills.map((skill) => skill.toMap()).toList(),
      Str.PROFILE_FIELD_WISHES: wishes.map((wish) => wish.toMap()).toList(),
      Str.PROFILE_FIELD_LAST_EDITED_TIME: lastEditedTime,
    };
  }

  ProfileModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? bio,
    List<SkillModel>? skills,
    List<WishModel>? wishes,
    int? lastEditedTime,
  }) {
    return ProfileModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      wishes: wishes ?? this.wishes,
      lastEditedTime: lastEditedTime ?? this.lastEditedTime,
    );
  }

  @override
  String toString() {
    return 'ProfileModel {${Str.PROFILE_FIELD_UID}: $uid, ${Str.PROFILE_FIELD_NAME}: $name, ${Str.PROFILE_FIELD_EMAIL}: $email, ${Str.PROFILE_FIELD_BIO}: $bio, ${Str.PROFILE_FIELD_SKILLS}: $skills, ${Str.PROFILE_FIELD_WISHES}: $wishes, ${Str.PROFILE_FIELD_LAST_EDITED_TIME}: $lastEditedTime}';
  }

  final _listEquality = const ListEquality();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileModel) return false;

    return uid == other.uid &&
        name == other.name &&
        email == other.email &&
        bio == other.bio &&
        _listEquality.equals(skills, other.skills) &&
        _listEquality.equals(wishes, other.wishes) &&
        lastEditedTime == other.lastEditedTime;
  }

  @override
  int get hashCode => Object.hash(
    uid,
    name,
    email,
    bio,
    _listEquality.hash(skills),
    _listEquality.hash(wishes),
    lastEditedTime,
  );
}
