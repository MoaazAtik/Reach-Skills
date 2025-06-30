import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/constants/values.dart';
import '../../../core/theme/styles.dart';
import '../../common/widgets/rs_chip.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.onSearch});

  // final void Function(String query) onSearch;
  final void Function() onSearch;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  var _isSearching = false;

  @override
  Widget build(BuildContext context) {
    if (!_isSearching) {
      return RsChip(
        onTap: () {
          setState(() {
            _isSearching = true;
          });
        },
        paddingRight: Values.paddingSmall,
        paddingLeft: Values.paddingSmall,
        children: [Icon(Icons.search_rounded, size: 20)],
      );
    }

    return Ink(
      height: Values.chipHeight,
      padding: EdgeInsets.only(left: Values.paddingMedium),
      decoration: BoxDecoration(
        color: Styles.skillChipBackgroundColor,
        borderRadius: BorderRadius.circular(Values.borderRadius),
      ),
      child: Row(
        children: [
          TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: Str.searchHint,
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: Values.fontSizeChip),
              constraints: BoxConstraints(maxWidth: 150),
              isDense: true,
              isCollapsed: true,
            ),
          ),
          IconButton(
            onPressed: widget.onSearch,
            padding: EdgeInsets.zero,
            icon: Icon(Icons.search_rounded, size: 20),
          ),
        ],
      ),
    );
  }
}
