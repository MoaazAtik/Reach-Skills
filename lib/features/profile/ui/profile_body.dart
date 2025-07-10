import 'package:flutter/material.dart';
import 'package:reach_skills/core/utils/utils.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';
import '../../common/widgets/rs_chip.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Styles.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  Str.mockUserName,
                  style: Styles.interestDetailsTitleTextStyle,
                ),
                SizedBox(height: 8),
                Text(
                  Str.mockInterestDescription,
                  textAlign: TextAlign.center,
                  style: Styles.interestDetailsUserTextStyle,
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
              spacing: Styles.spacingMedium,
              runSpacing: Styles.spacingMedium,
              children: List.generate(Str.mockTags.length * 3, (index) {
                return RsChip(
                  chipColor:
                      index % 3 == 0
                          ? Styles.wishChipBackgroundColor
                          : Styles.skillChipBackgroundColor,
                  children: [
                    Text(
                      Str.mockTags[index % Str.mockTags.length],
                      style: Styles.interestChipTextStyle,
                    ),
                  ],
                );
              }),
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
              '${Str.lastUpdated}: ${calculateDaysDifferenceAndFormat(DateTime(2025, 7, 8))}',
              style: Styles.interestDetailsUserTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
