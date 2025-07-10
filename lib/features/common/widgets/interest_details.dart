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
  });

  final bool isOwner;
  // Todo replace Str.mock... with interest...
  final InterestModel? interest;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Styles.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
            spacing: Styles.spacingMedium,
            runSpacing: Styles.spacingMedium,
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
          FilledButton(
            onPressed: () {},
            child: Text(Str.reach, style: Styles.rsFilledButtonTextStyle),
          ),
        ],
      ),
    );
  }
}
