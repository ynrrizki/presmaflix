import 'package:flutter/material.dart';

class CustomTabBarController extends StatefulWidget {
  const CustomTabBarController({
    super.key,
    required this.header,
    required this.tabCount,
    required this.tabs,
    required this.tabBarViews,
  });

  final Widget header;
  final int tabCount;
  final List<Tab> tabs;
  final List<Widget> tabBarViews;

  @override
  State<CustomTabBarController> createState() => _CustomTabBarControllerState();
}

class _CustomTabBarControllerState extends State<CustomTabBarController>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.tabCount, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.header,
              // tabbar
              // const DetailTabBarWidget(),
              TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: widget.tabs,
              ),
            ],
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: widget.tabBarViews,
      ),
    );
  }
}
