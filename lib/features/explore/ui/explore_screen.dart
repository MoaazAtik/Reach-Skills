import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/strings.dart';
import '../../chat/ui/messages_screen.dart';
import 'explore_viewmodel.dart';
import 'interest_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            '${Str.explore} '
            '${interests.length} ${Str.interests}:',
          ),
        ),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 3 / 1,
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

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) => MessagesScreen(
                              currentSenderId: exploreViewModel.currentSenderId,
                              currentSenderName:
                                  exploreViewModel.currentSenderName,
                              currentReceiverId:
                                  exploreViewModel.currentReceiverId,
                              currentReceiverName:
                                  exploreViewModel.currentReceiverName,
                            ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
