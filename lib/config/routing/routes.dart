import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:presmaflix/config/routing/argument/content/detail_args.dart';
import 'package:presmaflix/ui/pages/menu/bottom_navigation.dart';
import 'package:presmaflix/ui/pages/menu/home/content/detail_page.dart';

class AppRouter {
  Route onRoute(RouteSettings settings) {
    log('Route: ${settings.name}');
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
        );
      case "/detail":
        final args = settings.arguments as DetailArguments;
        return PageTransition(
          child: DetailPage(
            content: args.content,
          ),
          type: PageTransitionType.rightToLeft,
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text(
            '404 Not Found',
            style: TextStyle(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
