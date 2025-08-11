import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';
import '../../common/data/interest_model.dart';
import '../../common/widgets/rs_chip.dart';

class RsInterestsFilterMenu extends StatefulWidget {
  final void Function(List<InterestType> interestTypes) onTapFilter;

  const RsInterestsFilterMenu({super.key, required this.onTapFilter});

  @override
  State<RsInterestsFilterMenu> createState() => _RsInterestsFilterMenuState();
}

class _RsInterestsFilterMenuState extends State<RsInterestsFilterMenu> {
  String selected = _getMenuItems()[0].value;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 40),
      color: Styles.skillChipBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Styles.borderRadius),
      ),
      elevation: Styles.elevationMenu,
      borderRadius: BorderRadius.circular(Styles.borderRadius),

      initialValue: selected,
      itemBuilder: (context) => _getMenuItems(),
      onSelected: _selectFilter,

      child: RsChip(
        paddingRight: Styles.paddingSmall,
        children: [
          Text(
            selected.toString(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: Styles.fontSizeChip,
              fontWeight: Styles.fontWeightChip,
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded, size: 24),
        ],
      ),
    );
  }

  void _selectFilter(dynamic value) {
    final List<InterestType> interestTypes;
    if (value == Str.filterAll) {
      interestTypes = InterestType.values;
    } else {
      interestTypes = [
        value == Str.filterSkills ? InterestType.skill : InterestType.wish,
      ];
    }

    widget.onTapFilter(interestTypes);
    setState(() => selected = value);
  }
}

final _menuItemAll = PopupMenuItem<String>(
  value: Str.filterAll,
  child: Text(Str.filterAll),
);

final _menuItemSkills = PopupMenuItem(
  value: Str.filterSkills,
  child: Text(Str.filterSkills),
);

final _menuItemWishes = PopupMenuItem(
  value: Str.filterWishes,
  child: Text(Str.filterWishes),
);

List<PopupMenuItem<dynamic>> _getMenuItems() {
  return <PopupMenuItem>[_menuItemAll, _menuItemSkills, _menuItemWishes];
}
