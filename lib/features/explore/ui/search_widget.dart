import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/theme/styles.dart';
import '../../common/ui/rs_chip.dart';

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
        paddingRight: Styles.paddingSmall,
        paddingLeft: Styles.paddingSmall,
        children: [Icon(Icons.search_rounded, size: 20)],
      );
    }

    return Ink(
      height: Styles.chipHeight,
      padding: EdgeInsets.only(left: Styles.paddingMedium),
      decoration: BoxDecoration(
        color: Styles.skillChipBackgroundColor,
        borderRadius: BorderRadius.circular(Styles.borderRadius),
      ),
      child: Row(
        children: [
          TextFormField(
            controller: _searchController,
            decoration: Styles.rsInputDecoration(
              hint: Str.searchHint,
              withConstrains: true,
              maxWidth: 150,
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
