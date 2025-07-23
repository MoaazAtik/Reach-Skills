import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/common/data/interest_model.dart';
import 'package:reach_skills/features/profile/ui/profile_viewmodel.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';
import '../../common/data/skill_model.dart';
import '../../common/widgets/rs_chip.dart';
import '../domain/profile_model.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key, required this.onSignInPressed});

  final VoidCallback onSignInPressed;

  // Todo implement
  // to delete an interest on long pressing
  // final void Function()? onDeleteInterest;
  // passed to a SnackBar action to re-add a deleted interest
  // onReSaveInterest

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

  @override
  void initState() {
    super.initState();
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
                    _nameController.text,
                    style: Styles.interestDetailsTitleTextStyle,
                  ),
                if (isEditing)
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: Styles.rsInputDecoration(
                        label: Str.name,
                        hint: Str.nameHint,
                      ),
                      validator: textValidator,
                    ),
                  ),
                SizedBox(height: 8),
                if (!isEditing)
                  Text(
                    _bioController.text,
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
              children: _buildInterestsChips(interests: _interests),
            ),
            SizedBox(height: 28),
            Text(
              Str.account,
              style: Styles.interestDetailsSectionTitleTextStyle,
            ),
            SizedBox(height: 16),
            Text(
              _email ?? Str.errorFetchingEmail,
              style: Styles.interestDetailsDescriptionTextStyle,
            ),
            SizedBox(height: 16),
            Text(
              '${Str.lastUpdated}: ${calculateDaysDifferenceAndFormat(dateInMillis: _profile?.lastEditedTime)}',
              style: Styles.interestDetailsUserTextStyle,
            ),

            SizedBox(height: 56),
            if (isEditing)
              FilledButton(
                onPressed: () {
                  _saveProfile(null);
                },
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
    super.dispose();
  }

  List<Widget> _buildInterestsChips({required List<InterestModel> interests}) {
    final chips = List.generate(interests.length, (index) {
      return RsChip(
        onTap:
            () => showDetailsScreenDialog(
              context,
              interest: interests[index],
              onTapReach: () {},
              onTapSave: (InterestModel interest) {
                _saveProfile(interest);
              },
            ),
        chipColor: Styles.getChipColor(interests[index].interestType),
        children: [
          Text(interests[index].title, style: Styles.interestChipTextStyle),
        ],
      );
    });

    // Add a button for adding elements to the end of the list
    chips.insert(
      chips.length,
      RsChip(
        onTap:
            () => showDetailsScreenDialog(
              context,
              // Creating a 'Skill' as the default interest type
              /* Interest ID is autogenerated by the model. */
              interest: SkillModel(userId: _uid!, userName: _profile!.name),
              onTapSave: (InterestModel interest) {
                _saveProfile(interest);
              },
              startEditing: true,
            ),
        paddingRight: Styles.paddingSmall,
        paddingLeft: Styles.paddingSmall,
        children: [Icon(Icons.add_rounded, size: 20)],
      ),
    );

    return chips;
  }

  Future<void> _saveProfile(InterestModel? interest) async {
    final updateProfile = context.read<ProfileViewModel>().updateProfile;
    final ScaffoldMessengerState scaffoldMessengerState = ScaffoldMessenger.of(
      context,
    );

    if (!_formKey.currentState!.validate()) return;

    String updatingResult = await updateProfile(
      name: _nameController.text.trim(),
      bio: _bioController.text.trim(),
      interest: interest,
    );

    scaffoldMessengerState.showSnackBar(
      SnackBar(content: Text(updatingResult)),
    );
  }
}
