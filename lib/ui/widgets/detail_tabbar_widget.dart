import 'package:flutter/material.dart';

class DetailTabBarWidget extends StatefulWidget {
  const DetailTabBarWidget({
    super.key,
  });

  @override
  State<DetailTabBarWidget> createState() => _DetailTabBarWidgetState();
}

class _DetailTabBarWidgetState extends State<DetailTabBarWidget>
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
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: const [
              Tab(
                text: 'Trailer',
              ),
              Tab(
                text: 'Similar',
              )
            ],
          ),
          Expanded(
            // constraints: const BoxConstraints(
            //   maxWidth: double.infinity,
            //   // maxHeight: MediaQuery.of(context).size.height / 1.5,
            //   // minHeight: 100,
            //   maxHeight: 100,
            // ),
            child: TabBarView(
              controller: _tabController,
              children: [
                Scaffold(
                  body: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: 100,
                        color: Colors.blue,
                      ),
                      Container(
                        height: 100,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                Scaffold(
                  body: Column(
                    children: const [
                      Text('Tab 2'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
