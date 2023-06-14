import 'dart:developer';

import 'package:flutter/material.dart';

class TabBarController extends StatefulWidget {
  const TabBarController({
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
  State<TabBarController> createState() => _TabBarControllerState();
}

class _TabBarControllerState extends State<TabBarController>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void didUpdateWidget(TabBarController oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabCount != oldWidget.tabCount) {
      // Jika jumlah tab berubah, kita perlu mengupdate TabController
      _tabController.dispose();
      setState(() {
        _tabController = TabController(length: widget.tabCount, vsync: this);
      });
    }
  }

  @override
  void initState() {
    log("${widget.tabCount}", name: 'tabCount tabbar_controller');
    _tabController = TabController(length: widget.tabCount, vsync: this);
    // _tabController = TabController(length: 0, vsync: this);
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
      floatHeaderSlivers: true,
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.header,
              Container(
                color: Colors.grey[900],
                child: TabBar(
                  indicatorSize: widget.tabCount < 2
                      ? TabBarIndicatorSize.label
                      : TabBarIndicatorSize.tab,
                  controller: _tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: widget.tabs,
                ),
              ),
            ],
          ),
        ),
      ],
      body: TabBarView(
        physics: const BouncingScrollPhysics(),
        controller: _tabController,
        children: widget.tabBarViews,
      ),
    );
  }
}
