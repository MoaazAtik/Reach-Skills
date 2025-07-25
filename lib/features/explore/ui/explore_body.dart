import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/theme/styles.dart';
import 'package:reach_skills/features/common/data/skill_model.dart';
import 'package:reach_skills/features/explore/ui/search_widget.dart';

import '../../../core/constants/strings.dart';
import '../../common/data/interest_model.dart';
import '../../common/widgets/rs_chip.dart';
import 'explore_viewmodel.dart';
import 'interest_card.dart';

class ExploreBody extends StatefulWidget {
  const ExploreBody({super.key, required this.onInterestTap});

  final void Function(InterestModel interest) onInterestTap;

  @override
  State<ExploreBody> createState() => _ExploreBodyState();
}

class _ExploreBodyState extends State<ExploreBody> {
  @override
  Widget build(BuildContext context) {
    final exploreViewModel = context.watch<ExploreViewModel>();
    final loading = exploreViewModel.loading;

    final interests = exploreViewModel.interests;
    final interestsStreamError = exploreViewModel.interestsStreamError;

    List<String> mockList = Str.mockInterestsTitles;

    // if (loading) {
    //   return const Scaffold(body: Center(child: CircularProgressIndicator()));
    // }
    //
    // if (interestsStreamError != null) {
    //   return Center(child: Text(interestsStreamError));
    // }
    //
    // if (interests == null || interests.isEmpty) {
    //   return const Text(Str.noSkillsFound);
    // }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.padding12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: Styles.spacing12,
            children: [
              RsChip( // Todo implement
                onTap: () {},
                paddingRight: Styles.paddingSmall,
                children: [
                  Text(
                    Str.filterAll,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: Styles.fontSizeChip,
                      fontWeight: Styles.fontWeightChip,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 24),
                ],
              ),
              SearchWidget(onSearch: () {}), // Todo implement
            ],
          ),
          const SizedBox(height: Styles.spacing12),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4.1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children:
              // Todo replace mocks
              // [
                List.generate(mockList.length, (index) {
                  return InterestCard(
                    interestType: index % 4 != 0 ? InterestType.skill : InterestType.wish,
                    title: mockList[index],
                    userName: Str.mockUserName,
                    onTap: () {
                      widget.onInterestTap(SkillModel(
                        title: mockList[index],
                        id: Str.mockInterestId,
                        userName: Str.mockUserName,
                        userId: Str.mockUserId,
                      ));
                    },
                  );
                }),

                // for (final interest in interests)
                //   InterestCard(
                //     interestType: interest.interestType,
                //     title: interest.title,
                //     userName: interest.userName,
                //     onTap: () {
                //       widget.onInterestTap(interest);
                //     },
                //     // onReach: () async {
                //     //   String? errorMessage;
                //     //   errorMessage = await exploreViewModel.updateFields(
                //     //     currentReceiverId: interest.uid,
                //     //     currentReceiverName: interest.userName,
                //     //   );
                //     //
                //     //   if (errorMessage != null) {
                //     //     ScaffoldMessenger.of(
                //     //       context,
                //     //     ).showSnackBar(SnackBar(content: Text(errorMessage)));
                //     //     return;
                //     //   }
                //
                //     // Navigator.of(context).push(
                //     //   MaterialPageRoute(
                //     //     builder:
                //     //         (_) => MessagesScreen(
                //     //       currentSenderId: exploreViewModel.currentSenderId,
                //     //       currentSenderName:
                //     //       exploreViewModel.currentSenderName,
                //     //       currentReceiverId:
                //     //       exploreViewModel.currentReceiverId,
                //     //       currentReceiverName:
                //     //       exploreViewModel.currentReceiverName,
                //     //     ),
                //     //   ),
                //     // );
                //     // },
                //   ),
              // ],
            ),
          ),
        ],
      ),
    );
  }
}
