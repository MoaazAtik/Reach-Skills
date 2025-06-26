import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



// var myAppBar = AppBar(
//   backgroundColor: appBarColor,
//   title: Text(' '),
//   centerTitle: false,
// );

// Widget rsAppBar(BuildContext context) {

// class RSAppBar extends AppBar {
//   // final String title;
//   final Widget? leading;
//   final List<Widget>? actions;
//
//   const RSAppBar({super.key, required this.title, this.leading, this.actions});
//
//   @override
//   Widget build(BuildContext context) {
//     // return rsAppBar(context);
//     return AppBar(
//       title: Text(title),
//       centerTitle: true,
//       leading: leading,
//       actions: actions,
//     );
//   }
// }

// Widget rsNavigationBar() {
//   int _selectedIndex = 0;
//
//   return BottomNavigationBar(
//     items: const [
//       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//       BottomNavigationBarItem(icon: Icon(Icons.details), label: 'Details'),
//     ],
//     currentIndex: _selectedIndex,
//     onTap: (index) {
//       _selectedIndex = index;
//     },
//   );
// }

// class RSNavigationBar extends StatelessWidget {
//   const RSNavigationBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(Icons.details), label: 'Details'),
//       ],
//       currentIndex: _calculateSelectedIndex(context),
//       onTap: (int idx) => _onItemTapped(idx, context),
//     );
//   }
//
//   static int _calculateSelectedIndex(BuildContext context) {
//     final String location = GoRouterState.of(context).uri.path;
//     if (location.startsWith('/details')) {
//       return 1;
//     }
//     if (location.startsWith('/')) {
//       return 0;
//     }
//     return 0;
//   }
//
//   void _onItemTapped(int index, BuildContext context) {
//     switch (index) {
//       case 0:
//         GoRouter.of(context).go('/');
//       case 1:
//         GoRouter.of(context).go('/details');
//     }
//   }
// }
