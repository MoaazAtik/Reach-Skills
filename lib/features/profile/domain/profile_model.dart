import 'package:reach_skills/features/common/data/skill_model.dart';
import 'package:reach_skills/features/common/data/wish_model.dart';

class ProfileModel {
  final String uid;
  final String name;
  final String email;
  final String bio;
  final List<SkillModel> skills;
  final List<WishModel> wishes;
  final int lastEditedTime;

  static const String COLLECTION_NAME = 'profiles';
  static const String FIELD_UID = 'uid';
  static const String FIELD_NAME = 'name';
  static const String FIELD_EMAIL = 'email';
  static const String FIELD_BIO = 'bio';
  static const String FIELD_SKILLS = 'skills';
  static const String FIELD_WISHES = 'wishes';
  static const String FIELD_LAST_EDITED_TIME = 'lastEditedTime';

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
      uid: map[FIELD_UID],
      name: map[FIELD_NAME],
      email: map[FIELD_EMAIL],
      bio: map[FIELD_BIO],
      skills: List<SkillModel>.from(map[FIELD_SKILLS].map((skill) => SkillModel.fromMap(skill))),
      wishes: List<WishModel>.from(map[FIELD_WISHES].map((wish) => WishModel.fromMap(wish))),
      lastEditedTime: map[FIELD_LAST_EDITED_TIME],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FIELD_UID: uid,
      FIELD_NAME: name,
      FIELD_EMAIL: email,
      FIELD_BIO: bio,
      FIELD_SKILLS: skills.map((skill) => skill.toMap()).toList(),
      FIELD_WISHES: wishes.map((wish) => wish.toMap()).toList(),
      FIELD_LAST_EDITED_TIME: lastEditedTime,
    };
  }
}
