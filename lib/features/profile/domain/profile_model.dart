import 'package:collection/collection.dart';
import 'package:reach_skills/features/common/data/interest_model.dart';
import 'package:reach_skills/features/common/data/skill_model.dart';
import 'package:reach_skills/features/common/data/wish_model.dart';

import '../../../core/constants/strings.dart';

class ProfileModel {
  final String uid;
  final String name;
  final String email;
  final String bio;
  final List<InterestModel> interests;
  final int lastEditedTime;

  ProfileModel({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.bio = '',
    this.interests = const <InterestModel>[],
    this.lastEditedTime = 0,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      uid:
          map[Str.PROFILE_FIELD_UID] ??
          (throw Exception(
            '${Str.excMessageNullUserName} ${Str.excMessageProfileModelFromMap}',
          )),
      name:
          map[Str.PROFILE_FIELD_NAME] ??
          (throw Exception(
            '${Str.excMessageNullUserName} ${Str.excMessageProfileModelFromMap}',
          )),
      email:
          map[Str.PROFILE_FIELD_EMAIL] ??
          (throw Exception(
            '${Str.excMessageNullEmail} ${Str.excMessageProfileModelFromMap}',
          )),
      bio: map[Str.PROFILE_FIELD_BIO] ?? '',
      interests:
          map[Str.PROFILE_FIELD_INTERESTS] == null
              ? List<InterestModel>.empty()
              : List<InterestModel>.from(
                map[Str.PROFILE_FIELD_INTERESTS].map((interest) {
                  if (interest[Str.INTEREST_FIELD_INTEREST_TYPE] ==
                      InterestType.skill.name) {
                    return SkillModel.fromMap(interest);
                  } else {
                    return WishModel.fromMap(interest);
                  }
                }),
              ),
      lastEditedTime: map[Str.PROFILE_FIELD_LAST_EDITED_TIME] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Str.PROFILE_FIELD_UID: uid,
      Str.PROFILE_FIELD_NAME: name,
      Str.PROFILE_FIELD_EMAIL: email,
      Str.PROFILE_FIELD_BIO: bio,
      Str.PROFILE_FIELD_INTERESTS:
          interests.map((interest) {
            if (interest is SkillModel) {
              return interest.toMap();
            } else {
              return (interest as WishModel).toMap();
            }
          }).toList(),
      Str.PROFILE_FIELD_LAST_EDITED_TIME: lastEditedTime,
    };
  }

  ProfileModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? bio,
    List<InterestModel>? interests,
    int? lastEditedTime,
  }) {
    return ProfileModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      lastEditedTime: lastEditedTime ?? this.lastEditedTime,
    );
  }

  @override
  String toString() {
    return 'ProfileModel {${Str.PROFILE_FIELD_UID}: $uid, ${Str.PROFILE_FIELD_NAME}: $name, ${Str.PROFILE_FIELD_EMAIL}: $email, ${Str.PROFILE_FIELD_BIO}: $bio, ${Str.PROFILE_FIELD_INTERESTS}: $interests, ${Str.PROFILE_FIELD_LAST_EDITED_TIME}: $lastEditedTime}';
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
        _listEquality.equals(interests, other.interests) &&
        lastEditedTime == other.lastEditedTime;
  }

  @override
  int get hashCode => Object.hash(
    uid,
    name,
    email,
    bio,
    _listEquality.hash(interests),
    lastEditedTime,
  );
}
