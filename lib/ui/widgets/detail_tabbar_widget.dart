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
                    children: const [],
                  ),
                ),
                Scaffold(
                  body: Column(
                    children: const [
                      // Text('Tab 2'),
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
