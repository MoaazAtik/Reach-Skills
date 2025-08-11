import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reach_skills/core/theme/styles.dart';
import 'package:reach_skills/features/explore/ui/rs_interests_filter_menu.dart';
import 'package:reach_skills/features/explore/ui/search_widget.dart';

import '../../common/data/interest_model.dart';
import 'explore_viewmodel.dart';
import 'interest_card.dart';

class ExploreBody extends StatefulWidget {
  const ExploreBody({
    super.key,
    required this.onTapInterest,
    this.interests = const [],
  });

  final void Function(InterestModel interest) onTapInterest;
  final List<InterestModel> interests;

  @override
  State<ExploreBody> createState() => _ExploreBodyState();
}

class _ExploreBodyState extends State<ExploreBody> {
  @override
  Widget build(BuildContext context) {
    // final exploreViewModel = context.watch<ExploreViewModel>();
    // final loading = exploreViewModel.loading;

    // final interests = exploreViewModel.interests;
    // final interestsStreamError = exploreViewModel.interestsStreamError;


    final interests = context.select<ExploreViewModel, List<InterestModel>>(
      (exploreViewModel) => exploreViewModel.interests,
    );
    final void Function(List<InterestType> interestTypes) onTapFilter =
        context.read<ExploreViewModel>().startInterestsSubscription;
    // final interests = <InterestModel>[SkillModel(title: 'Flutter'), WishModel(title: 'Dart')];
    // final interests = widget.interests;

    // Todo uncomment
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
              // Filter widget
              RsInterestsFilterMenu(onTapFilter: onTapFilter),

              // Search widget // Todo implement
              SearchWidget(onSearch: () {}),
            ],
          ),
          const SizedBox(height: Styles.spacing12),

          // Interest Cards
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4.1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              children: List.generate(interests.length, (index) {
                return InterestCard(
                  interestType: interests[index].interestType,
                  title: interests[index].title,
                  userName: interests[index].userName,
                  onTap: () {
                    widget.onTapInterest(interests[index]);
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
