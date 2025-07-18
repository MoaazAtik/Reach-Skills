import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/common/data/interest_model.dart';
import 'package:reach_skills/features/profile/ui/profile_viewmodel.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';
import '../../common/data/skill_model.dart';
import '../../common/data/wish_model.dart';
import '../../common/widgets/rs_chip.dart';
import '../domain/profile_model.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key, required this.onSignInPressed});

  final VoidCallback onSignInPressed;

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_ProfileBodyState');

  String? _uid;
  String? _email;
  ProfileModel? _profile;
  List<InterestModel> _interests = [];

  late TextEditingController _nameController;
  late TextEditingController _bioController;

  // late TextEditingController _interestsController;
  late final Future<String> Function(ProfileModel newProfile) updateProfile;

  @override
  void initState() {
    super.initState();
    updateProfile = context.read<ProfileViewModel>().updateProfile;
    context.read<ProfileViewModel>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();
    _uid = profileViewModel.uid;
    _email = profileViewModel.email;
    _profile = profileViewModel.profile;
    _interests = profileViewModel.interests;
    final bool loading = profileViewModel.loading;

    bool isEditing = profileViewModel.isEditing;
    _nameController = TextEditingController(text: _profile?.name);
    _bioController = TextEditingController(text: _profile?.bio);
    // _interestsController = TextEditingController(text: profileViewModel.profile?.interests);

    if (_uid == null) {
      return Column(
        children: [
          const SizedBox(height: 40),
          Text(Str.noUserInfoMessage),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: widget.onSignInPressed,
            child: const Text(Str.signIn),
          ),
        ],
      );
    }

    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Styles.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                if (!isEditing)
                  Text(
                    Str.mockUserName,
                    // _nameController.text,
                    style: Styles.interestDetailsTitleTextStyle,
                  ),
                if (isEditing)
                  TextFormField(
                    controller: _nameController,
                    decoration: Styles.rsInputDecoration(
                      label: Str.name,
                      hint: Str.nameHint,
                    ),
                    validator: textValidator,
                  ),
                SizedBox(height: 8),
                if (!isEditing)
                  Text(
                    Str.mockInterestDescription,
                    // _bioController.text,
                    textAlign: TextAlign.center,
                    style: Styles.interestDetailsUserTextStyle,
                  ),
                if (isEditing)
                  TextFormField(
                    controller: _bioController,
                    decoration: Styles.rsInputDecoration(
                      label: Str.bio,
                      hint: Str.bioHint,
                    ),
                    maxLines: 5,
                    minLines: 1,
                  ),
              ],
            ).withFullWidth(),

            SizedBox(height: 40),
            Text(
              Str.interests.xToSentenceCase(),
              style: Styles.interestDetailsSectionTitleTextStyle,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: Styles.spacing12,
              runSpacing: Styles.spacing12,
              // Todo implement
              children: _buildInterestsChips(interests: Str.mockTags),
              // children: _buildInterestsChips(interests: _interests),
            ),
            SizedBox(height: 28),
            Text(
              Str.account,
              style: Styles.interestDetailsSectionTitleTextStyle,
            ),
            SizedBox(height: 16),
            Text(
              Str.mockEmail,
              // _email ?? Str.errorFetchingEmail,
              style: Styles.interestDetailsDescriptionTextStyle,
            ),
            SizedBox(height: 16),
            Text(
              '${Str.lastUpdated}: ${calculateDaysDifferenceAndFormat(dateTime: Str.mockDateTimeObject)}',
              // '${Str.lastUpdated}: ${calculateDaysDifferenceAndFormat(dateInMillis: _profile?.lastEditedTime)}',
              style: Styles.interestDetailsUserTextStyle,
            ),

            SizedBox(height: 56),
            if (isEditing)
              FilledButton(
                onPressed: () => _saveProfile(updateProfile, null),
                child: Text(
                  Str.saveProfile,
                  style: Styles.rsFilledButtonTextStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    // _interestsController.dispose();
    super.dispose();
  }

  // List<Widget> _buildInterestsChips({required List<InterestModel> interests}) { // Todo remove
  List<Widget> _buildInterestsChips({required List<String> interests}) {
    final chips = List.generate(interests.length * 3, (index) {
      // final chips = interests.map((interest) {
      return RsChip(
        // Todo remove *3 and % interest.length.
        // Todo implement onTap.
        // onTap: // Todo uncomment
        //     () => showDetailsScreenDialog(
        //       context,
        //       isOwner: true,
        //       interest: interests[index],
        //       onTapReach: () {
        //       },
        //       onTapSave: (InterestModel interest) {
        //         _saveProfile(updateProfile, interest);
        //       },
        //     ),
        chipColor:
            // interests[index % interests.length].interestType ==
            //         InterestType.wish
            index % 3 == 0
                ? Styles.wishChipBackgroundColor
                : Styles.skillChipBackgroundColor,
        children: [
          Text(
            // interests[index % interests.length].title,
            interests[index % interests.length],
            style: Styles.interestChipTextStyle,
          ),
        ],
      );
    });

    // Add a button for adding elements to the end of the list
    chips.insert(
      chips.length,
      RsChip(
        onTap:
            () =>
                showDetailsScreenDialog(context, isOwner: true, interest: null),
        paddingRight: Styles.paddingSmall,
        paddingLeft: Styles.paddingSmall,
        children: [Icon(Icons.add_rounded, size: 20)],
      ),
    );

    return chips;
  }

  // Todo implement
  Future<void> _saveProfile(
    Future<String> Function(ProfileModel newProfile) updateProfile,
    InterestModel? interest,
  ) async {
    String updatingResult;
    final ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(
      context,
    );

    if (!_formKey.currentState!.validate()) {
      updatingResult = Str.fillRequiredFields;
    } else if (_uid == null) {
      updatingResult = Str.unknownErrorSignAgain;
    } else {
      // final tempList = List<InterestModel>.from(_interests);
      // final tempList = interest.interestType == InterestType.skill ? _interests.where((element) => element.interestType == InterestType.skill).toList() : _interests.where((element) => element.interestType == InterestType.wish).toList();

      // final tempList = interest.interestType == InterestType.skill ? _profile!.skills : _profile!.wishes;
      /* Used '.from' instead of 'final tempList = _interests' to avoid losing
      the updated interest if _interests is accessed outside of this method
      eg, on another platform. */
      final tempList = List<InterestModel>.from(_interests);
      if (interest != null) {
        tempList.add(interest);
      }

      final newProfile = _profile!.copyWith(
        name: _nameController.text.trim(),
        bio: _bioController.text.trim(),
        skills: tempList.where((element) => element.interestType == InterestType.skill) as List<SkillModel>,
        wishes: tempList.where((element) => element.interestType == InterestType.wish) as List<WishModel>,
        lastEditedTime: DateTime.now().millisecondsSinceEpoch,
      );

      updatingResult = await updateProfile(newProfile);
    }

    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(updatingResult)),
    );
  }
}
