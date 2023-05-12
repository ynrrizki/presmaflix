import 'package:flutter/material.dart';

class TabBarViewWidget extends StatefulWidget {
  const TabBarViewWidget({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<TabBarViewWidget> createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index % 2 == 0) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                height: 100,
                color: Colors.blue,
              );
            }
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              height: 100,
              color: Colors.red,
            );
          },
          itemCount: 100,
        ),
        Column(
          children: const [
            Text('Tab 2'),
          ],
        ),
      ],
    );
  }
}



// import 'package:flutter/material.dart';

// class DetailTabBarWidget extends StatefulWidget {
//   const DetailTabBarWidget({
//     super.key,
//   });

//   @override
//   State<DetailTabBarWidget> createState() => _DetailTabBarWidgetState();
// }

// class _DetailTabBarWidgetState extends State<DetailTabBarWidget>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   List<String> _tabs = ['Tab 1', 'Tab 2'];
//   List<Widget> _tabViews = [
//     Container(
//       child: Center(
//         child: Text('Tab 1'),
//       ),
//     ),
//     Container(
//       child: Center(
//         child: Text('Tab 2'),
//       ),
//     ),
//   ];

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Create a custom TabBar. Don't use BuiltIn Tab bar
//     return Column(
//       children: [
//         TabBar(
//           controller: _tabController,
//           tabs: _tabs.map((e) => Tab(text: e)).toList(),
//         ),
//         ListView(
//           shrinkWrap: true,
//           children: [
//             TabBarView(
//               controller: _tabController,
//               children: _tabViews.map((e) => e).toList(),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
