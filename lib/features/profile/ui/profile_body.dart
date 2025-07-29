import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/routing/routing.dart';
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
    context.read<ProfileViewModel>().init();
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
                        fillColor: Styles.skillChipBackgroundColor,
                      ),
                      validator: textValidator,
                    ),
                  ),
                SizedBox(
                  height:
                      isEditing ? Styles.spacingMedium : Styles.spacingSmall,
                ),
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
                      fillColor: Styles.skillChipBackgroundColor,
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

            // Save button
            SizedBox(height: 56),
            if (isEditing)
              FilledButton(
                onPressed: () {
                  saveProfile(
                    context: context,
                    formKey: _formKey,
                    name: _nameController.text.trim(),
                    bio: _bioController.text.trim(),
                  );
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
            () => onTapInterest(
              context: context,
              interest: interests[index],
              fromPath: Str.profileScreenRoutePath,
            ),
        onLongPress: () {
          final interest = interests[index];
          context.read<ProfileViewModel>().removeInterest(interest: interest);
          showSnackBarMessage(
            context,
            '${Str.removed} ${interest.title}',
            actionLabel: Str.undo,
            onActionPressed: () {
              saveProfile(
                context: context,
                formKey: _formKey,
                name: _nameController.text.trim(),
                bio: _bioController.text.trim(),
                interest: interest,
              );
            },
          );
        },
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
            () => onTapInterest(
              context: context,
              // Creating a 'Skill' as the default interest type
              /* Interest ID is autogenerated by the model. */
              interest: SkillModel(userId: _uid!, userName: _profile!.name),
              fromPath: Str.profileScreenRoutePath,
              startEditing: true,
            ),
        paddingRight: Styles.paddingSmall,
        paddingLeft: Styles.paddingSmall,
        children: [Icon(Icons.add_rounded, size: 20)],
      ),
    );

    return chips;
  }
}

Future<void> saveProfile({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  String? name,
  String? bio,
  InterestModel? interest,
}) async {
  final updateProfile = context.read<ProfileViewModel>().updateProfile;
  final scaffoldMessengerState = ScaffoldMessenger.of(context);

  if (formKey.currentState != null && !formKey.currentState!.validate()) {
    return;
  }

  final String updatingResult = await updateProfile(
    name: name,
    bio: bio,
    interest: interest,
  );

  scaffoldMessengerState.showSnackBar(SnackBar(content: Text(updatingResult)));
}
