import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:presmaflix/ui/pages/menu/home/home_page.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return const [
        HomePage(),
        Scaffold(),
        Scaffold(),
        Scaffold(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: "Home",
          // activeColorPrimary: CupertinoColors.activeOrange,
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.heart),
          title: "For You",
          // activeColorPrimary: CupertinoColors.activeOrange,
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.square_stack_fill),
          title: "Daftarku",
          // activeColorPrimary: CupertinoColors.activeOrange,
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.profile_circled),
          title: "Profile",
          // activeColorPrimary: CupertinoColors.activeOrange,
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
              Colors.white,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: false,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // duration: Duration(milliseconds: 300),
        animateTabTransition: true,
        curve: Curves.easeInOut,
      ),
      navBarStyle: NavBarStyle.style3,
      hideNavigationBar: false,
    );
  }
}
