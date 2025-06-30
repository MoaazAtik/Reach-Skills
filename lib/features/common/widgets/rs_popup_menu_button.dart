import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/constants/values.dart';
import '../../../core/theme/styles.dart';

class RsPopupMenuButton extends StatelessWidget {
  const RsPopupMenuButton({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<dynamic>(
      icon: const Icon(Icons.more_vert_rounded),
      offset: const Offset(0, 50),
      color: Styles.skillChipBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Values.borderRadius),
      ),
      elevation: Values.menuElevation,
      itemBuilder: (BuildContext context) => _getMenuItems(isLoggedIn),
      onSelected: _onMenuItemSelected,
    );
  }
}

final _menuItemSignOut = PopupMenuItem(
  value: Str.signOut,
  child: Text(Str.signOut),
);

final _menuItemEditProfile = PopupMenuItem(
  value: Str.editProfile,
  child: Text(Str.editProfile),
);

final _menuItemSignIn = PopupMenuItem(
  value: Str.signIn,
  child: Text(Str.signIn),
);

final _menuItemHelp = PopupMenuItem(value: Str.help, child: Text(Str.help));

List<PopupMenuItem<dynamic>> _getMenuItems(bool isLoggedIn) {
  if (isLoggedIn) {
    return <PopupMenuItem>[
      _menuItemSignOut,
      _menuItemEditProfile,
      _menuItemHelp,
    ];
  } else {
    return <PopupMenuItem>[_menuItemSignIn, _menuItemHelp];
  }
}

void _onMenuItemSelected(dynamic value) {
  if (value == _menuItemSignOut.value) {
    print('Sign out selected');
  } else if (value == _menuItemEditProfile.value) {
    print('Edit profile selected');
  } else if (value == _menuItemHelp.value) {
    print('Help selected');
  } else if (value == _menuItemSignIn.value) {
    print('Sign in selected');
  }
  // switch (value) {
  //   case Str.signOut:
  //     print('Sign out selected');
  //     break;
  //   case Str.editProfile:
  //     print('Edit profile selected');
  //     break;
  //   case Str.help:
  //     print('Help selected');
  //     break;
  //   case Str.signIn:
  //     print('Sign in selected');
  //     break;
  // }
}
