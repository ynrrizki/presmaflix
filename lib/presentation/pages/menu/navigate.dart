import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:presmaflix/presentation/cubits/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:presmaflix/presentation/config/themes_config.dart';
import 'package:presmaflix/presentation/pages/menu/download/download_page.dart';
import 'package:presmaflix/presentation/pages/pages.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/foundation.dart' show kIsWeb;

class Navigate extends StatelessWidget {
  const Navigate({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const SidebarNavigation();
    }
    return const BottomNavigation();
  }
}

class SidebarNavigation extends StatefulWidget {
  const SidebarNavigation({super.key});

  @override
  State<SidebarNavigation> createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends State<SidebarNavigation> {
  List<Widget> buildScreens() {
    return const [
      HomePage(),
      DownloadPage(),
      WatchListPage(),
      MorePage(),
    ];
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                    Colors.white,
            selectedIndex: _selectedIndex,
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            selectedIconTheme: IconThemeData(color: kPrimaryColor),
            selectedLabelTextStyle: TextStyle(
              color: kPrimaryColor,
            ),
            unselectedLabelTextStyle: const TextStyle(
              color: Colors.white,
            ),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(CupertinoIcons.house),
                selectedIcon: Icon(CupertinoIcons.house_fill),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.download_outlined),
                selectedIcon: Icon(Icons.download),
                label: Text('Download'),
              ),
              NavigationRailDestination(
                icon: Icon(CupertinoIcons.bookmark),
                selectedIcon: Icon(CupertinoIcons.bookmark_fill),
                label: Text('Watchlist'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.menu),
                selectedIcon: Icon(Icons.menu),
                label: Text('More'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: buildScreens().elementAt(_selectedIndex),
          ),
        ],
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, this.index = 0});
  final int index;

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller =
        PersistentTabController(initialIndex: index);

    DateTime preBackpress = DateTime.now();

    final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

    List<Widget> buildScreens() {
      return const [
        HomePage(),
        DownloadPage(),
        WatchListPage(),
        MorePage(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          iconSize: 24,
          icon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -10, end: -12),
            showBadge: false,
            ignorePointer: false,
            badgeContent: const Text('3'),
            child: const Icon(CupertinoIcons.house_fill),
          ),
          title: "Home",
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
          inactiveIcon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -0, end: -9),
            showBadge: false,
            ignorePointer: false,
            badgeContent: const Text('3'),
            child: const Icon(CupertinoIcons.house),
          ),
        ),
        PersistentBottomNavBarItem(
          iconSize: 24,
          icon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -0, end: -9),
            showBadge: false,
            ignorePointer: false,
            badgeContent: const Text('3'),
            child: const Icon(Icons.download),
          ),
          title: "Download",
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
          inactiveIcon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -0, end: -9),
            showBadge: false,
            ignorePointer: false,
            badgeContent: const Text('3'),
            child: const Icon(Icons.download_outlined),
          ),
        ),
        PersistentBottomNavBarItem(
          iconSize: 24,
          icon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -0, end: -9),
            showBadge: false,
            ignorePointer: false,
            badgeContent: const Text('3'),
            child: const Icon(CupertinoIcons.bookmark_fill),
          ),
          title: "Watchlist",
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
          inactiveIcon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -0, end: -9),
            showBadge: false,
            ignorePointer: false,
            badgeContent: const Text('3'),
            child: const Icon(CupertinoIcons.bookmark),
          ),
        ),
        PersistentBottomNavBarItem(
          iconSize: 24,
          icon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -0, end: -9),
            showBadge: false,
            ignorePointer: false,
            badgeContent: const Text('3'),
            child: const Icon(Icons.menu),
          ),
          title: "More",
          activeColorPrimary: Theme.of(context).primaryColor,
          inactiveColorPrimary: Colors.grey,
          inactiveIcon: badges.Badge(
            position: badges.BadgePosition.topEnd(top: -0, end: -9),
            showBadge: false,
            ignorePointer: false,
            badgeContent: const Text('3'),
            child: const Icon(Icons.menu),
          ),
        ),
      ];
    }

    return NotificationListener<UserScrollNotification>(
      onNotification: (scrollNotification) {
        final direction = scrollNotification.direction;
        if (direction == ScrollDirection.forward) {
          context.read<BottomNavigationCubit>().updateIsHide(false);
        } else if (direction == ScrollDirection.reverse) {
          context.read<BottomNavigationCubit>().updateIsHide(true);
        }
        return false;
      },
      child: GestureDetector(
        onTap: () => context.read<BottomNavigationCubit>().updateIsHide(false),
        child: BlocBuilder<BottomNavigationCubit, bool>(
          builder: (context, state) {
            return PersistentTabView(
              context,
              decoration: const NavBarDecoration(),
              key: globalKey,
              controller: controller,
              onWillPop: (context) async {
                final timegap = DateTime.now().difference(preBackpress);
                final canExit = timegap >= const Duration(seconds: 2);

                preBackpress = DateTime.now();
                if (canExit) {
                  ScaffoldMessenger.of(context!).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Tekan Exit Kembali Untuk Keluar",
                        style: const TextStyle().copyWith(
                          color: Colors.white,
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return false;
                } else {
                  return true;
                }
              },
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
                curve: Curves.ease,
              ),
              screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.easeInOut,
              ),
              navBarStyle: NavBarStyle.style3,
              // hideNavigationBar: state,
            );
          },
        ),
      ),
    );
  }
}
