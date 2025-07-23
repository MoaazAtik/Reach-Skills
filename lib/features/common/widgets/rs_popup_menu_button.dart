import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';

class RsPopupMenuButton extends StatelessWidget {
  const RsPopupMenuButton({
    super.key,
    required this.isLoggedIn,
    required this.onTapSignIn,
    required this.onTapSignOut,
    required this.onTapEditProfile,
    required this.onTapHelp,
  });

  final bool isLoggedIn;

  final void Function() onTapSignIn;
  final void Function() onTapSignOut;
  final void Function() onTapEditProfile;
  final void Function() onTapHelp;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<dynamic>(
      icon: const Icon(Icons.more_vert_rounded),
      offset: const Offset(0, 50),
      color: Styles.skillChipBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Styles.borderRadius),
      ),
      elevation: Styles.menuElevation,
      itemBuilder: (BuildContext context) => _getMenuItems(isLoggedIn),
      onSelected: _onMenuItemSelected,
    );
  }

  void _onMenuItemSelected(dynamic value) {
    if (value == _menuItemSignOut.value) {
      onTapSignOut();
    } else if (value == _menuItemEditProfile.value) {
      onTapEditProfile();
    } else if (value == _menuItemHelp.value) {
      onTapHelp();
    } else if (value == _menuItemSignIn.value) {
      onTapSignIn();
    }
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
