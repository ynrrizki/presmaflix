import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presmaflix/config/routing/argument/content/all_content_args.dart';
import 'package:presmaflix/config/routing/argument/content/detail_content_args.dart';
import 'package:presmaflix/ui/pages/menu/bottom_navigation.dart';
import 'package:presmaflix/ui/pages/menu/home/content/content_all_page.dart';
import 'package:presmaflix/ui/pages/menu/home/content/content_detail_page.dart';
import 'package:presmaflix/ui/pages/menu/search/search_page.dart';
import 'package:presmaflix/ui/pages/menu/home/content/content_video_page.dart';

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
        return CupertinoPageRoute(
          builder: (context) => ContentDetailPage(
            content: args.content,
          ),
        );
      case "/all-content":
        final args = settings.arguments as AllContentArguments;
        return CupertinoPageRoute(
          builder: (context) => ContentAllPage(
            title: args.title,
            contents: args.contents,
          ),
        );
      case "/search":
        return CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => const SearchPage(),
        );
      case "/video-page":
        return CupertinoPageRoute(
          builder: (context) => const ContentVideoPage(),
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
