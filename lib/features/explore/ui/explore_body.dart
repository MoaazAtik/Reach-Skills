import 'package:flutter/material.dart';

class ExploreBody extends StatelessWidget {
  const ExploreBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Card(child: FilledButton(onPressed: () {}, child: Text('All'))),
              Card(
                child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              ),
            ],
          ),
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
