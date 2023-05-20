import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:presmaflix/config/routing/argument/content/all_content_args.dart';
import 'package:presmaflix/config/routing/argument/content/detail_content_args.dart';
import 'package:presmaflix/ui/pages/menu/bottom_navigation.dart';
import 'package:presmaflix/ui/pages/menu/home/content/all_content_page.dart';
import 'package:presmaflix/ui/pages/menu/home/content/detail_content_page.dart';

class AppRouter {
  Route onRoute(RouteSettings settings) {
    log('Route: ${settings.name}');

    switch (settings.name) {
      case "/":
        return CupertinoPageRoute(
          builder: (context) => const BottomNavigation(),
        );
      case "/detail-content":
        final args = settings.arguments as DetailContentArguments;
        return PageTransition(
          child: DetailContentPage(
            content: args.content,
          ),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
        );
      case "/all-content":
        final args = settings.arguments as AllContentArguments;
        return PageTransition(
          child: AllContentPage(
            title: args.title,
            contents: args.contents,
          ),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
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
