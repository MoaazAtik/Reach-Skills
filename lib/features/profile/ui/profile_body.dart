import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/utils/utils.dart';
import 'package:reach_skills/features/profile/ui/profile_viewmodel.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';
// import '../../common/data/interest_model.dart';
// import '../../common/widgets/interest_details.dart';
import '../../common/widgets/rs_chip.dart';
// import '../domain/profile_model.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  // final _formKey = GlobalKey<FormState>(debugLabel: '_ProfileBodyState');
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  // late TextEditingController _interestsController;

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    bool isEditing = profileViewModel.isEditing;
    _nameController = TextEditingController(
      text: profileViewModel.profile?.name,
    );
    _bioController = TextEditingController(text: profileViewModel.profile?.bio);
    // _interestsController = TextEditingController(text: profileViewModel.profile?.interests);

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
            ),
            SizedBox(height: 40),
            Text(
              Str.interests.xToSentenceCase(),
              style: Styles.interestDetailsSectionTitleTextStyle,
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: Styles.spacing12,
              runSpacing: Styles.spacing12,
              children: _buildInterestsChips(interests: Str.mockTags),
            ),
            SizedBox(height: 28),
            Text(
              Str.account,
              style: Styles.interestDetailsSectionTitleTextStyle,
            ),
            SizedBox(height: 16),
            Text(
              Str.mockEmail,
              style: Styles.interestDetailsDescriptionTextStyle,
            ),
            SizedBox(height: 16),
            Text(
              '${Str.lastUpdated}: ${calculateDaysDifferenceAndFormat(DateTime(2025, 7, 1))}',
              style: Styles.interestDetailsUserTextStyle,
            ),

            SizedBox(height: 56),
            if (isEditing)
              FilledButton(
                onPressed: () {},
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

  List<Widget> _buildInterestsChips({required List<String> interests}) {
    final chips = List.generate(interests.length * 3, (index) {
      return RsChip(
        // onTap: () => showDetailsScreenDialog(context, isOwner: true, interest: interest),
        chipColor:
            index % 3 == 0
                ? Styles.wishChipBackgroundColor
                : Styles.skillChipBackgroundColor,
        children: [
          Text(
            interests[index % interests.length],
            style: Styles.interestChipTextStyle,
          ),
        ],
      );
    });

    // Add add button to the end of the list
    chips.insert(
      chips.length,
      RsChip(
        onTap: () => showDetailsScreenDialog(context, isOwner: true, interest: null),
        paddingRight: Styles.paddingSmall,
        paddingLeft: Styles.paddingSmall,
        children: [Icon(Icons.add_rounded, size: 20)],
      ),
    );

    return chips;
  }
}
