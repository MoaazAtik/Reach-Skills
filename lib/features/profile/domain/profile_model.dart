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
      skills: List<SkillModel>.from(map[Str.PROFILE_FIELD_SKILLS].map((skill) => SkillModel.fromMap(skill))),
      wishes: List<WishModel>.from(map[Str.PROFILE_FIELD_WISHES].map((wish) => WishModel.fromMap(wish))),
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
}
