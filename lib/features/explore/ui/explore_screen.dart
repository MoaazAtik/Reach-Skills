import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'explore_viewmodel.dart';

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
      children: [
        for (final interest in interests)
          ListTile(
            title: Text(interest.title),
            subtitle: Text('by ${interest.userName}'),
          ),
      ],
    );
  }
}
