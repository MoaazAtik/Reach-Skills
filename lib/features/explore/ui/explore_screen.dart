import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'explore_viewmodel.dart';
import 'interest_cart.dart';

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

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final interest in interests)
          InterestCard(
            interestType: interest.interestType,
            title: interest.title,
            userName: interest.userName,
            onReach: () => print('Reach ${interest.userName}'),
          ),
      ],
    );
  }
}
