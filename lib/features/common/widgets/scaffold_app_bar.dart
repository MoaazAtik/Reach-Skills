import 'package:flutter/material.dart';

import 'rs_app_bar.dart';

class ScaffoldAppBar extends StatelessWidget {
  const ScaffoldAppBar({
    super.key,
    required this.body,
    required this.appBarTitle,
  });

  final Widget body;
  final String appBarTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: rsAppBar(
        title: appBarTitle,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
