import 'package:flutter/material.dart';

import '../../../core/constants/strings.dart';
import '../../../core/constants/values.dart';
import '../../common/widgets/rs_chip.dart';

class ExploreBody extends StatelessWidget {
  const ExploreBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Values.padding12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            spacing: Values.spacingMedium,
            children: [
              RsChip(
                onTap: () {
                  print('tap');
                },
                paddingRight: Values.paddingSmall,
                children: [
                  Text(
                    Str.filterAll,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontSize: Values.fontSizeChip,
                      fontWeight: Values.fontWeightChip,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded, size: 24),
                ],
              ),
              RsChip(
                // onTap: () {},
                paddingRight: Values.paddingSmall,
                paddingLeft: Values.paddingSmall,
                children: [Icon(Icons.search_rounded, size: 20)],
              ),
            ],
          ),
          const SizedBox(height: Values.spacingMedium),
          Expanded(
            child: GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 2 / 3,
                // crossAxisSpacing: 20,
                // mainAxisSpacing: 20,
              ),
              children: [
                Column(
                  children: [
                    Card(child: SizedBox(width: 100, height: 100)),
                    Text('data'),
                  ],
                ),
                Column(
                  children: [
                    Card(child: SizedBox(width: 100, height: 100)),
                    Text('data'),
                  ],
                ),
                Column(
                  children: [
                    Card(child: SizedBox(width: 100, height: 100)),
                    Text('data'),
                  ],
                ),
                Column(
                  children: [
                    Card(child: SizedBox(width: 100, height: 100)),
                    Text('data'),
                  ],
                ),
                Column(
                  children: [
                    Card(child: SizedBox(width: 100, height: 100)),
                    Text('data'),
                  ],
                ),
                // Card(child: ListTile(title: Text("Item 0"))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
