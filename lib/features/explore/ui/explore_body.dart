import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/features/explore/ui/search_widget.dart';

import '../../../core/constants/strings.dart';
import '../../../core/constants/values.dart';
import '../../common/widgets/rs_chip.dart';
import 'explore_viewmodel.dart';
import 'interest_card.dart';

class ExploreBody extends StatefulWidget {
  const ExploreBody({super.key});

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
      padding: const EdgeInsets.symmetric(horizontal: Values.padding12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: Values.spacingMedium,
            children: [
              RsChip(
                onTap: () {},
                paddingRight: Values.paddingSmall,
                children: [
                  Text(
                    Str.filterAll,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: Values.fontSizeChip,
                      fontWeight: Values.fontWeightChip,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 24),
                ],
              ),
              SearchWidget(onSearch: () {}),
            ],
          ),
          const SizedBox(height: Values.spacingMedium),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: [
                for (final interest in interests)
                  InterestCard(
                    interestType: interest.interestType,
                    title: interest.title,
                    userName: interest.userName,
                    onReach: () async {
                      String? errorMessage;
                      errorMessage = await exploreViewModel.updateFields(
                        currentReceiverId: interest.uid,
                        currentReceiverName: interest.userName,
                      );

                      if (errorMessage != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(errorMessage)));
                        return;
                      }

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
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
