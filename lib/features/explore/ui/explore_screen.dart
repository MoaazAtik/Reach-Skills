import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../chat/ui/messages_screen.dart';
import 'explore_viewmodel.dart';
import 'interest_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exploreViewModel = context.watch<ExploreViewModel>();
    final interests = exploreViewModel.interests;
    final loading = exploreViewModel.loading;

    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (interests == null || interests.isEmpty) {
      return const Text('No skills found');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text(
            'Explore '
            '${interests.length} interests:',
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
                        currentReceiverName: interest.userName
                    );

                    if (errorMessage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(errorMessage)),
                      );
                      return;
                    }

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) => MessagesScreen.fromExplore(
                              currentSenderId: exploreViewModel.currentSenderId,
                              currentSenderName: exploreViewModel.currentSenderName,
                              currentReceiverId: exploreViewModel.currentReceiverId,
                              currentReceiverName: exploreViewModel.currentReceiverName,
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
