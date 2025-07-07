import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/theme/styles.dart';
import 'package:reach_skills/features/common/widgets/interest_details.dart';
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

    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (interestsStreamError != null) {
      return Center(child: Text(interestsStreamError));
    }

    if (interests == null || interests.isEmpty) {
      return const Text(Str.noSkillsFound);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Styles.padding12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: Styles.spacingMedium,
            children: [
              RsChip(
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
              SearchWidget(onSearch: () {}),
            ],
          ),
          const SizedBox(height: Styles.spacingMedium),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4.1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: [
                for (final interest in interests)
                  InterestCard(
                    interestType: interest.interestType,
                    title: interest.title,
                    userName: interest.userName,
                    onTap: () {
                      widget.onInterestTap(interest);
                    },
                    // onReach: () async {
                    //   String? errorMessage;
                    //   errorMessage = await exploreViewModel.updateFields(
                    //     currentReceiverId: interest.uid,
                    //     currentReceiverName: interest.userName,
                    //   );
                    //
                    //   if (errorMessage != null) {
                    //     ScaffoldMessenger.of(
                    //       context,
                    //     ).showSnackBar(SnackBar(content: Text(errorMessage)));
                    //     return;
                    //   }

                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder:
                    //         (_) => MessagesScreen(
                    //       currentSenderId: exploreViewModel.currentSenderId,
                    //       currentSenderName:
                    //       exploreViewModel.currentSenderName,
                    //       currentReceiverId:
                    //       exploreViewModel.currentReceiverId,
                    //       currentReceiverName:
                    //       exploreViewModel.currentReceiverName,
                    //     ),
                    //   ),
                    // );
                    // },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
