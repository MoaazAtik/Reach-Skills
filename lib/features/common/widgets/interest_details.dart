import 'package:flutter/material.dart';
import 'package:reach_skills/core/constants/strings.dart';
import 'package:reach_skills/core/theme/styles.dart';
import 'package:reach_skills/features/common/data/interest_model.dart';
import 'package:reach_skills/features/common/widgets/rs_chip.dart';

class InterestDetails extends StatelessWidget {
  const InterestDetails({
    super.key,
    required this.isOwner,
    required this.interest,
    this.onTapReach,
    this.onTapSave,
  });

  final bool isOwner;
  // Todo replace Str.mock... with interest...
  final InterestModel? interest;
  final void Function()? onTapReach;
  final InterestModel Function()? onTapSave;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Styles.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row( // Todo fix row Render flex overflow on large screen
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Str.mockInterestTitle,
                    style: Styles.interestDetailsTitleTextStyle,
                  ),
                  Text(
                    '${Str.by} ${Str.mockUserName}',
                    style: Styles.interestDetailsUserTextStyle,
                  ),
                ],
              ),
              // if (owner)
              IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined)),
            ],
          ),
          SizedBox(height: 24),
          Text(
            Str.mockInterestDescription,
            style: Styles.interestDetailsDescriptionTextStyle,
          ),
          SizedBox(height: 24),
          Text(Str.type, style: Styles.interestDetailsSectionTitleTextStyle),
          SizedBox(height: 16),
          RsChip(
            children: [Text(Str.skill, style: Styles.interestChipTextStyle)],
          ),
          SizedBox(height: 24),
          Text(Str.tags, style: Styles.interestDetailsSectionTitleTextStyle),
          SizedBox(height: 16),
          Wrap(
            spacing: Styles.spacing12,
            runSpacing: Styles.spacing12,
            children: List.generate(Str.mockTags.length, (index) {
              return RsChip(
                children: [
                  Text(
                    Str.mockTags[index],
                    style: Styles.interestChipTextStyle,
                  ),
                ],
              );
            }),
          ),

          SizedBox(height: 56),
          // Todo implement
          // if (!isOwner || isEditing)
          FilledButton(
            onPressed: () {
              if (isOwner) {
                if (onTapSave != null) {
                  onTapSave!();
                } else {
                  throw Exception('onTapSave is not provided to InterestDetails widget');
                }
              } else if (onTapReach != null) {
                onTapReach!();
              } else {
                throw Exception('onTapReach or onTapSave must be provided to InterestDetails widget');
              }
            },
            child: Text(
                isOwner ? Str.reach : Str.save,
                style: Styles.rsFilledButtonTextStyle
            ),
          ),
        ],
      ),
    );
  }
}
