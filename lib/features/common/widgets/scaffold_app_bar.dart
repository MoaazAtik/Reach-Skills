import 'package:flutter/material.dart';
import 'package:reach_skills/core/theme/styles.dart';

import '../../../core/constants/strings.dart';
import '../../../core/constants/values.dart';
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
      body: SafeArea(child: body),
      appBar: rsAppBar(
        context: context,
        title: appBarTitle,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded),
            offset: const Offset(0, 50),
            color: Styles.skillChipBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Values.borderRadius),
            ),
            elevation: Values.menuElevation,
            // menuPadding: const EdgeInsets.all(4),
            // padding: const EdgeInsets.all(8),
            // borderRadius: BorderRadius.circular(Values.borderRadius),
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    value: 1,
                    child: Text(Str.signOut),
                    onTap: () {},
                  ),
                  const PopupMenuItem(value: 2, child: Text(Str.editProfile)),
                  const PopupMenuItem(value: 3, child: Text(Str.help)),
                ],
            onSelected: (value) {
              switch (value) {
                // case 1:
                //   print('Item 1 selected');
                //   break;
                case 2:
                  print('Item 2 selected');
                  break;
                case 3:
                  print('Item 3 selected');
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
